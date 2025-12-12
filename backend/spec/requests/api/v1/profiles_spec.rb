require "rails_helper"

RSpec.describe "Api::V1::Profiles", type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { { name: "John Doe", department: "Engineering" } }
  let(:invalid_attributes) { { name: "", department: "" } }

  describe "GET /api/v1/profile" do
    context "when user has a profile" do
      let!(:profile) { create(:user_profile, user: user) }

      it "returns the user profile" do
        get "/api/v1/profile", headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(%w[id name department user_id])
        expect(json_response["name"]).to eq(profile.name)
        expect(json_response["department"]).to eq(profile.department)
      end
    end

    context "when user has no profile" do
      it "returns not found" do
        get "/api/v1/profile", headers: auth_headers(user)

        expect(response).to have_http_status(:not_found)
        expect_json_response(["message"])
        expect(json_response["message"]).to eq("Profile not found")
      end
    end

    context "without authentication" do
      it "returns unauthorized error" do
        get "/api/v1/profile", headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end

  describe "POST /api/v1/profile" do
    context "with valid parameters" do
      it "creates a new profile" do
        expect do
          post "/api/v1/profile", params: valid_attributes, headers: auth_headers(user)
        end.to change(UserProfile, :count).by(1)

        expect(response).to have_http_status(:created)
        expect_json_response(%w[id name department user_id])
        expect(json_response["name"]).to eq("John Doe")
        expect(json_response["department"]).to eq("Engineering")
      end
    end

    context "with invalid parameters" do
      it "returns validation errors" do
        post "/api/v1/profile", params: invalid_attributes, headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to be_an(Array)
      end
    end

    context "when profile already exists" do
      let!(:existing_profile) { create(:user_profile, user: user) }

      it "returns error message" do
        post "/api/v1/profile", params: valid_attributes, headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to eq("Profile already exists")
      end
    end

    context "without authentication" do
      it "returns unauthorized error" do
        post "/api/v1/profile", params: valid_attributes, headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end

  describe "PUT /api/v1/profile" do
    let!(:profile) { create(:user_profile, user: user, name: "Old Name", department: "Old Dept") }
    let(:update_attributes) { { name: "New Name", department: "New Department" } }

    context "with valid parameters" do
      it "updates the profile" do
        put "/api/v1/profile", params: update_attributes, headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(%w[id name department user_id])
        expect(json_response["name"]).to eq("New Name")
        expect(json_response["department"]).to eq("New Department")

        profile.reload
        expect(profile.name).to eq("New Name")
        expect(profile.department).to eq("New Department")
      end
    end

    context "with invalid parameters" do
      it "returns validation errors" do
        put "/api/v1/profile", params: invalid_attributes, headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to be_an(Array)
      end
    end

    context "when profile does not exist" do
      let!(:user_without_profile) { create(:user) }

      it "returns not found error" do
        put "/api/v1/profile", params: update_attributes, headers: auth_headers(user_without_profile)

        expect(response).to have_http_status(:not_found)
        expect_json_response(["errors"])
        expect(json_response["errors"]).to eq("Profile not found")
      end
    end

    context "without authentication" do
      it "returns unauthorized error" do
        put "/api/v1/profile", params: update_attributes, headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(["errors"])
      end
    end
  end
end
