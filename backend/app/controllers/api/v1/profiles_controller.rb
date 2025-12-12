module Api
  module V1
    class ProfilesController < ApplicationController
      include JwtAuthenticatable

      def show
        profile = current_user.user_profile

        if profile
          render json: profile, status: :ok
        else
          render json: { message: "Profile not found" }, status: :not_found
        end
      end

      def create
        if current_user.user_profile.present?
          render json: { errors: "Profile already exists" }, status: :unprocessable_content
          return
        end

        profile = current_user.build_user_profile(profile_params)

        if profile.save
          render json: profile, status: :created
        else
          render json: { errors: profile.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        profile = current_user.user_profile

        if profile.nil?
          render json: { errors: "Profile not found" }, status: :not_found
          return
        end

        if profile.update(profile_params)
          render json: profile, status: :ok
        else
          render json: { errors: profile.errors.full_messages }, status: :unprocessable_content
        end
      end

      private

      def profile_params
        params.permit(:name, :department)
      end
    end
  end
end
