module Api
  module V1
    class WelcomeController < ApplicationController
      def index
        render json: { message: "Welcome to the API!", timestamp: Time.current }
      end
    end
  end
end
