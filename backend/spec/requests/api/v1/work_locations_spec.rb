require 'rails_helper'

RSpec.describe 'Api::V1::WorkLocations', type: :request do
  let!(:user) { create(:user) }
  let!(:profile) { create(:user_profile, user: user) }
  let!(:other_user) { create(:user) }
  let!(:other_profile) { create(:user_profile, user: other_user) }

  describe 'GET /api/v1/work_locations/today' do
    let!(:work_location1) { create(:work_location, :office, user_profile: profile, date: Date.current) }
    let!(:work_location2) { create(:work_location, :remote, user_profile: other_profile, date: Date.current) }
    let!(:old_work_location) { create(:work_location, :office, user_profile: profile, date: Date.yesterday) }

    context 'with authentication' do
      it 'returns today\'s work locations for all users' do
        get '/api/v1/work_locations/today', headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(['work_locations'])
        
        work_locations = json_response['work_locations']
        expect(work_locations.size).to eq(2)
        
        expect(work_locations).to all(include('id', 'name', 'department', 'status', 'date'))
        expect(work_locations.map { |wl| wl['status'] }).to contain_exactly('office', 'remote')
        expect(work_locations.all? { |wl| wl['date'] == Date.current.to_s }).to be true
      end
    end

    context 'without authentication' do
      it 'returns unauthorized error' do
        get '/api/v1/work_locations/today', headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(['errors'])
      end
    end
  end

  describe 'POST /api/v1/work_locations' do
    context 'with valid parameters' do
      it 'creates a new work location for today' do
        expect {
          post '/api/v1/work_locations', params: { status: 'office' }, headers: auth_headers(user)
        }.to change(WorkLocation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect_json_response(['id', 'status', 'date', 'user_profile_id'])
        expect(json_response['status']).to eq('office')
        expect(json_response['date']).to eq(Date.current.to_s)
      end

      it 'updates existing work location for today' do
        existing_location = create(:work_location, :remote, user_profile: profile, date: Date.current)
        
        expect {
          post '/api/v1/work_locations', params: { status: 'office' }, headers: auth_headers(user)
        }.not_to change(WorkLocation, :count)

        expect(response).to have_http_status(:created)
        expect(json_response['status']).to eq('office')
        
        existing_location.reload
        expect(existing_location.status).to eq('office')
      end
    end

    context 'with invalid status' do
      it 'returns validation error' do
        post '/api/v1/work_locations', params: { status: 'invalid_status' }, headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(['errors'])
        expect(json_response['errors']).to be_an(Array)
      end
    end

    context 'without profile' do
      let!(:user_without_profile) { create(:user) }

      it 'returns error message' do
        post '/api/v1/work_locations', params: { status: 'office' }, headers: auth_headers(user_without_profile)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(['errors'])
        expect(json_response['errors']).to eq('Profile not found. Please create a profile first.')
      end
    end

    context 'without authentication' do
      it 'returns unauthorized error' do
        post '/api/v1/work_locations', params: { status: 'office' }, headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(['errors'])
      end
    end
  end

  describe 'PUT /api/v1/work_locations/:id' do
    let!(:work_location) { create(:work_location, :office, user_profile: profile) }

    context 'with valid parameters and ownership' do
      it 'updates the work location' do
        put "/api/v1/work_locations/#{work_location.id}", 
            params: { status: 'remote' }, 
            headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(['id', 'status', 'date', 'user_profile_id'])
        expect(json_response['status']).to eq('remote')
        
        work_location.reload
        expect(work_location.status).to eq('remote')
      end
    end

    context 'with invalid status' do
      it 'returns validation error' do
        put "/api/v1/work_locations/#{work_location.id}", 
            params: { status: 'invalid_status' }, 
            headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
        expect_json_response(['errors'])
        expect(json_response['errors']).to be_an(Array)
      end
    end

    context 'when work location does not exist' do
      it 'returns not found error' do
        put '/api/v1/work_locations/999999', 
            params: { status: 'remote' }, 
            headers: auth_headers(user)

        expect(response).to have_http_status(:not_found)
        expect_json_response(['errors'])
        expect(json_response['errors']).to eq('Work location not found')
      end
    end

    context 'when user does not own the work location' do
      let!(:other_work_location) { create(:work_location, :office, user_profile: other_profile) }

      it 'returns forbidden error' do
        put "/api/v1/work_locations/#{other_work_location.id}", 
            params: { status: 'remote' }, 
            headers: auth_headers(user)

        expect(response).to have_http_status(:forbidden)
        expect_json_response(['errors'])
        expect(json_response['errors']).to eq('Unauthorized')
      end
    end

    context 'without authentication' do
      it 'returns unauthorized error' do
        put "/api/v1/work_locations/#{work_location.id}", 
            params: { status: 'remote' }, 
            headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(['errors'])
      end
    end
  end

  describe 'GET /api/v1/work_locations/history' do
    let!(:work_location1) { create(:work_location, :office, user_profile: profile, date: Date.current) }
    let!(:work_location2) { create(:work_location, :remote, user_profile: profile, date: Date.yesterday) }
    let!(:other_work_location) { create(:work_location, :office, user_profile: other_profile, date: Date.current) }

    context 'with profile' do
      it 'returns user\'s work location history' do
        get '/api/v1/work_locations/history', headers: auth_headers(user)

        expect(response).to have_http_status(:ok)
        expect_json_response(['work_locations'])
        
        work_locations = json_response['work_locations']
        expect(work_locations.size).to eq(2)
        expect(work_locations.map { |wl| wl['id'] }).to contain_exactly(work_location1.id, work_location2.id)
        
        # Check that results are ordered by date descending
        dates = work_locations.map { |wl| Date.parse(wl['date']) }
        expect(dates).to eq(dates.sort.reverse)
      end
    end

    context 'without profile' do
      let!(:user_without_profile) { create(:user) }

      it 'returns empty array' do
        get '/api/v1/work_locations/history', headers: auth_headers(user_without_profile)

        expect(response).to have_http_status(:ok)
        expect_json_response(['work_locations'])
        expect(json_response['work_locations']).to eq([])
      end
    end

    context 'without authentication' do
      it 'returns unauthorized error' do
        get '/api/v1/work_locations/history', headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect_json_response(['errors'])
      end
    end
  end
end