require 'rails_helper'

RSpec.describe "Api::V1::Welcome", type: :request do
  describe "GET /api/v1/welcome" do
    it "returns a welcome message" do
      get "/api/v1/welcome"
      
      expect(response).to have_http_status(:success)
      expect(json_response["message"]).to eq("Welcome to the API!")
      expect(json_response).to have_key("timestamp")
    end
    
    it "returns JSON content type" do
      get "/api/v1/welcome"
      
      expect(response.content_type).to match(/application\/json/)
    end
  end
end
