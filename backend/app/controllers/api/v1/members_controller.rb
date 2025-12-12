module Api
  module V1
    class MembersController < ApplicationController
      include JwtAuthenticatable

      def index
        users = User.all
        render json: users.map { |user|
          {
            id: user.id,
            username: user.username,
            profile: user.user_profile
          }
        }, status: :ok
      end
    end
  end
end