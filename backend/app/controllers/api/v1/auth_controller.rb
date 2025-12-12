class Api::V1::AuthController < ApplicationController
  include JwtAuthenticatable
  
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    user = User.new(user_params)
    
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: { id: user.id, username: user.username, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(username: params[:username])
    
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { id: user.id, username: user.username, token: token }, status: :ok
    else
      render json: { errors: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def logout
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  def current_user_info
    if current_user
      render json: { 
        id: current_user.id, 
        username: current_user.username,
        profile: current_user.user_profile
      }, status: :ok
    else
      render json: { errors: 'Not authenticated' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end