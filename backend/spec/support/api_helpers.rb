module ApiHelpers
  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def auth_headers(user)
    token = jwt_encode(user_id: user.id)
    {
      "Authorization" => "Bearer #{token}",
      "HOST" => "localhost:3000"
    }
  end

  def default_headers
    { "HOST" => "localhost:3000" }
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, jwt_secret)
  end

  def jwt_secret
    Rails.application.credentials.secret_key_base || "fallback_secret_key_for_development"
  end

  def expect_json_response(expected_keys)
    expect(response.content_type).to include("application/json")
    expect(json_response.keys).to include(*expected_keys)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :request
end
