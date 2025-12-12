class Api::V1::WelcomeController < ApplicationController
  def index
    render json: { message: "Welcome to the API!", timestamp: Time.current }
  end
end