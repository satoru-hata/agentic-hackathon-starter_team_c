# Employee Work Location System - Backend

Rails API for managing employee work location tracking system.

## Features

- JWT-based authentication
- User profile management
- Work location tracking (office/remote/out_of_office)
- Daily work location status for all employees

## Requirements

* Ruby version: 3.0.6

## Setup

### Prerequisites

- Ruby 3.0.6
- PostgreSQL
- Docker (recommended)

### Installation

1. **Using Docker (Recommended)**
   ```bash
   # Start the services
   docker compose up -d
   
   # Install dependencies
   docker compose exec backend bundle install
   
   # Setup database
   docker compose exec backend rails db:migrate
   ```

2. **Local Setup**
   ```bash
   bundle install
   rails db:setup
   rails db:migrate
   ```

## Development Commands

### Docker Commands (Recommended)

```bash
# Start all services
docker compose up -d

# Stop all services  
docker compose down

# View logs
docker compose logs -f backend

# Install/update gems
docker compose exec backend bundle install

# Database operations
docker compose exec backend rails db:create
docker compose exec backend rails db:migrate
docker compose exec backend rails db:seed

# Run Rails console
docker compose exec backend rails console

# Run tests
docker compose exec backend rspec

# Code quality checks
docker compose exec backend bundle exec rubocop
docker compose exec backend bundle exec rubocop -A  # Auto-fix issues
```

## API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - Login
- `DELETE /api/v1/auth/logout` - Logout
- `GET /api/v1/auth/current_user` - Get current user

### Profile Management
- `GET /api/v1/profile` - Get profile
- `POST /api/v1/profile` - Create profile
- `PUT /api/v1/profile` - Update profile

### Work Locations
- `GET /api/v1/work_locations/today` - Today's all employee locations
- `POST /api/v1/work_locations` - Register today's location
- `PUT /api/v1/work_locations/:id` - Update location
- `GET /api/v1/work_locations/history` - Personal location history

## Testing

### Running Tests

```bash
# Run all tests
docker compose exec backend rspec

# Run with detailed output
docker compose exec backend rspec --format documentation

# Run specific test file
docker compose exec backend rspec spec/requests/api/v1/auth_spec.rb

# Run specific test
docker compose exec backend rspec spec/requests/api/v1/auth_spec.rb:10
```

### Test Coverage

- **37 test cases** covering all API endpoints
- Authentication and authorization tests
- Input validation tests
- Error handling tests
- Database constraint tests

### Test Structure

```
spec/
├── factories/           # FactoryBot factories
│   ├── users.rb
│   ├── user_profiles.rb
│   └── work_locations.rb
├── support/
│   └── api_helpers.rb   # API test helpers
└── requests/api/v1/     # API endpoint tests
    ├── auth_spec.rb
    ├── profiles_spec.rb
    └── work_locations_spec.rb
```

## Code Quality

This project uses RuboCop for code linting and style enforcement.

### Running RuboCop

#### Using Docker (Recommended)

To check your code for style issues:

```bash
docker compose exec backend bundle exec rubocop
```

To automatically fix correctable offenses:

```bash
docker compose exec backend bundle exec rubocop -a
```

To automatically fix all offenses (including unsafe corrections):

```bash
docker compose exec backend bundle exec rubocop -A
```

#### Local Setup

If running locally without Docker:

```bash
bundle exec rubocop        # Check for issues
bundle exec rubocop -a     # Auto-fix correctable issues
bundle exec rubocop -A     # Auto-fix all issues (including unsafe)
```

### RuboCop Configuration

The RuboCop configuration is defined in `.rubocop.yml` and includes:

- RuboCop Rails plugin for Rails-specific cops
- RuboCop Performance plugin for performance-related suggestions
- Custom rules tailored for this Rails API project
- Exclusions for generated files and third-party code

## Development

### Database Schema

- `users` - Authentication data
- `user_profiles` - Employee information
- `work_locations` - Daily work location records

### Environment Variables

- `DATABASE_HOST` - Database host
- `DATABASE_USERNAME` - Database username  
- `DATABASE_PASSWORD` - Database password
- `RAILS_ENV` - Rails environment

## Technology Stack

- **Backend**: Ruby on Rails 7.1 (API mode)
- **Database**: PostgreSQL
- **Authentication**: JWT tokens with bcrypt
- **Testing**: RSpec with FactoryBot
- **Code Quality**: RuboCop with Rails and Performance plugins
- **Deployment**: Docker
