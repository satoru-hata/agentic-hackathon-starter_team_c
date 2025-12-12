module JwtAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split.last if header

    begin
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError
      render json: { errors: "Invalid token" }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "User not found" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, jwt_secret)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, jwt_secret)[0]
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  end

  def jwt_secret
    Rails.application.credentials.secret_key_base || "fallback_secret_key_for_development"
  end
end
