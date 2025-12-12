# Employee Work Location System - Backend

Rails API for managing employee work location tracking system.

## Features

- JWT-based authentication
- User profile management
- Work location tracking (office/remote/out_of_office)
- Daily work location status for all employees

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
- **Deployment**: Docker
