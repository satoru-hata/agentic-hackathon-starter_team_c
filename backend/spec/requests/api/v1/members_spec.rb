require "rails_helper"

RSpec.describe "Api::V1::Members", type: :request do
  describe "GET /api/v1/members" do
    let!(:user1) { create(:user, :with_profile, username: "user1") }
    let!(:user2) { create(:user, :with_profile, username: "user2") }
    let!(:user3) { create(:user, username: "user3") }

    context "with valid token" do
      it "returns all members with their profiles" do
        get "/api/v1/members", headers: auth_headers(user1)

        expect(response).to have_http_status(:ok)
        expect(json_response).to be_an(Array)
        expect(json_response.length).to eq(3)

        # Check that all users are returned
        usernames = json_response.map { |user| user["username"] }
        expect(usernames).to contain_exactly("user1", "user2", "user3")

        # Check response structure
        json_response.each do |user_data|
          expect(user_data).to have_key("id")
          expect(user_data).to have_key("username")
          expect(user_data).to have_key("profile")
        end

        # Check that users with profiles have profile data
        user_with_profile = json_response.find { |u| u["username"] == "user1" }
        expect(user_with_profile["profile"]).to be_present

        # Check that users without profiles have null profile
        user_without_profile = json_response.find { |u| u["username"] == "user3" }
        expect(user_without_profile["profile"]).to be_nil
      end
    end

    context "without token" do
      it "returns unauthorized error" do
        get "/api/v1/members", headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end

    context "with invalid token" do
      it "returns unauthorized error" do
        get "/api/v1/members", headers: default_headers.merge({ "Authorization" => "Bearer invalid_token" })

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end

    context "when no members exist" do
      it "returns empty array" do
        User.destroy_all
        current_user = create(:user)

        get "/api/v1/members", headers: auth_headers(current_user)

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq([{
          "id" => current_user.id,
          "username" => current_user.username,
          "profile" => current_user.user_profile
        }])
      end
    end
  end
end