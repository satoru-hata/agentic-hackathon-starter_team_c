require "rails_helper"

RSpec.describe "Api::V1::Auth", type: :request do
  describe "POST /api/v1/auth/register" do
    let(:valid_attributes) { { username: "testuser", password: "password123" } }
    let(:invalid_attributes) { { username: "", password: "short" } }

    context "with valid parameters" do
      it "creates a new user and returns token" do
        expect do
          post "/api/v1/auth/register", params: valid_attributes, headers: default_headers
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect_json_response(%w[id username token])
        expect(json_response["username"]).to eq("testuser")
        expect(json_response["token"]).to be_present
      end
    end

    context "with invalid parameters" do
      it "returns validation errors" do
        post "/api/v1/auth/register", params: invalid_attributes, headers: default_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to be_an(Array)
      end
    end

    context "with duplicate username" do
      it "returns validation error" do
        create(:user, username: "testuser")

        post "/api/v1/auth/register", params: valid_attributes, headers: default_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(["errors"])
      end
    end
  end

  describe "POST /api/v1/auth/login" do
    let!(:user) { create(:user, username: "testuser", password: "password123") }

    context "with valid credentials" do
      it "returns user information and token" do
        post "/api/v1/auth/login", params: { username: "testuser", password: "password123" }, headers: default_headers

        expect(response).to have_http_status(:ok)
        expect_json_response(%w[id username token])
        expect(json_response["username"]).to eq("testuser")
        expect(json_response["token"]).to be_present
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized error" do
        post "/api/v1/auth/login", params: { username: "testuser", password: "wrongpassword" }, headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to eq("Invalid username or password")
      end
    end

    context "with non-existent user" do
      it "returns unauthorized error" do
        post "/api/v1/auth/login", params: { username: "nonexistent", password: "password123" },
                                   headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end

  describe "DELETE /api/v1/auth/logout" do
    let!(:user) { create(:user) }

    context "with valid token" do
      it "returns success message" do
        delete "/api/v1/auth/logout", headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(["message"])
        expect(json_response["message"]).to eq("Logged out successfully")
      end
    end

    context "without token" do
      it "returns unauthorized error" do
        delete "/api/v1/auth/logout", headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end

  describe "GET /api/v1/auth/current_user" do
    let!(:user) { create(:user, :with_profile) }

    context "with valid token" do
      it "returns current user information" do
        get "/api/v1/auth/current_user", headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(%w[id username profile])
        expect(json_response["username"]).to eq(user.username)
        expect(json_response["profile"]).to be_present
      end
    end

    context "without token" do
      it "returns unauthorized error" do
        get "/api/v1/auth/current_user", headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end

    context "with invalid token" do
      it "returns unauthorized error" do
        get "/api/v1/auth/current_user", headers: default_headers.merge({ "Authorization" => "Bearer invalid_token" })

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end
end
