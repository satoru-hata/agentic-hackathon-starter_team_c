# RSpec Configuration for Backend

This directory contains the RSpec test configuration for the Rails backend API.

## Setup

RSpec has been configured with the following gems:

- **rspec-rails**: Rails integration for RSpec
- **factory_bot_rails**: Fixture replacement for Rails
- **faker**: Generate fake data for tests
- **shoulda-matchers**: Simple one-liner tests for common Rails functionality
- **database_cleaner-active_record**: Database cleaning strategies for tests

## Running Tests

To run all tests:

```bash
bundle exec rspec
```

To run a specific test file:

```bash
bundle exec rspec spec/requests/api/v1/welcome_spec.rb
```

To run tests with documentation format:

```bash
bundle exec rspec --format documentation
```

## Database Setup

Before running tests, ensure your test database is set up:

```bash
# Create the test database
RAILS_ENV=test bundle exec rails db:create

# Run migrations
RAILS_ENV=test bundle exec rails db:migrate
```

## Directory Structure

- `spec/requests/` - Request specs (API endpoint tests)
- `spec/support/` - Helper modules and shared examples

Create additional directories as needed for your project:
- `spec/models/` - Model specs
- `spec/controllers/` - Controller specs
- `spec/factories/` - FactoryBot factories for test data
- `spec/helpers/` - Helper specs
- `spec/mailers/` - Mailer specs
- `spec/jobs/` - Job specs

## Writing Tests

### Request Spec Example

```ruby
require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/users" do
    it "returns a list of users" do
      get "/api/v1/users"
      
      expect(response).to have_http_status(:success)
      expect(json_response).to be_an(Array)
    end
  end
end
```

### Using FactoryBot

Create a factory in `spec/factories/users.rb`:

```ruby
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
```

Use in tests:

```ruby
let(:user) { create(:user) }
```

## Configuration Files

- `.rspec` - RSpec command line options
- `spec/spec_helper.rb` - Basic RSpec configuration
- `spec/rails_helper.rb` - Rails-specific RSpec configuration
- `spec/support/request_spec_helper.rb` - Helper methods for request specs

## Notes

- Tests run in random order by default to catch test interdependencies
- Database is cleaned between test runs using DatabaseCleaner
- FactoryBot methods (`create`, `build`, etc.) are available in all specs
