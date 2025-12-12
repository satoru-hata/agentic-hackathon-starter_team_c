# Database Setup

This directory contains the database migrations for the Employee Work Location System.

## Migrations

The following migrations have been created based on spec.md:

1. **20251212061000_create_users.rb** - Users table for authentication
   - id, username, password_digest, timestamps
   - Unique index on username

2. **20251212061001_create_employee_profiles.rb** - Employee profiles table
   - id, user_id (foreign key), name, department, timestamps
   - Unique index on user_id

3. **20251212061002_create_work_locations.rb** - Work locations table
   - id, employee_profile_id (foreign key), status, date, timestamps
   - Index on date
   - Unique composite index on (employee_profile_id, date)

## Running Migrations

To run the migrations, execute:

```bash
# Using Docker Compose
docker compose exec backend rails db:migrate

# Or locally (if Rails is installed)
cd backend
bundle install
rails db:migrate
```

## Database Schema

After running migrations, the schema will include:

- **users**: User authentication
- **employee_profiles**: Employee profile information
- **work_locations**: Daily work location status (office/remote/out_of_office)

## Notes

- The bcrypt gem has been added to the Gemfile for password encryption
- Models have been created in app/models/ with appropriate associations and validations
