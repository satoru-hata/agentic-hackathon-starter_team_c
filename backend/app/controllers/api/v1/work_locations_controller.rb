class Api::V1::WorkLocationsController < ApplicationController
  include JwtAuthenticatable

  def today
    today = Date.current
    work_locations = WorkLocation
      .joins(user_profile: :user)
      .where(date: today)
      .select('work_locations.*, user_profiles.name, user_profiles.department')
    
    result = work_locations.map do |wl|
      {
        id: wl.id,
        name: wl.name,
        department: wl.department,
        status: wl.status,
        date: wl.date
      }
    end
    
    render json: { work_locations: result }, status: :ok
  end

  def create
    profile = current_user.user_profile
    
    if profile.nil?
      render json: { errors: 'Profile not found. Please create a profile first.' }, status: :unprocessable_entity
      return
    end

    today = Date.current
    work_location = profile.work_locations.find_or_initialize_by(date: today)
    work_location.status = params[:status]
    
    if work_location.save
      render json: work_location, status: :created
    else
      render json: { errors: work_location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    work_location = WorkLocation.find_by(id: params[:id])
    
    if work_location.nil?
      render json: { errors: 'Work location not found' }, status: :not_found
      return
    end
    
    if work_location.user_profile.user_id != current_user.id
      render json: { errors: 'Unauthorized' }, status: :forbidden
      return
    end
    
    if work_location.update(status: params[:status])
      render json: work_location, status: :ok
    else
      render json: { errors: work_location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def history
    profile = current_user.user_profile
    
    if profile.nil?
      render json: { work_locations: [] }, status: :ok
      return
    end
    
    work_locations = profile.work_locations.order(date: :desc)
    render json: { work_locations: work_locations }, status: :ok
  end
end