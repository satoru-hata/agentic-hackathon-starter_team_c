# Database Setup

This directory contains the database migrations for the Employee Work Location System.

## Migrations

The following migrations have been created based on spec.md:

1. **20251212061000_create_users.rb** - Users table for authentication
   - id, username, password_digest, timestamps
   - Unique index on username

2. **20251212061001_create_user_profiles.rb** - User profiles table
   - id, user_id (foreign key), name, department, timestamps
   - Unique index on user_id

3. **20251212061002_create_work_locations.rb** - Work locations table
   - id, user_profile_id (foreign key), status, date, timestamps
   - Index on date
   - Unique composite index on (user_profile_id, date)

## Running Migrations

### Option 1: Using SQL Script (Recommended if bundle install has issues)

```bash
# Tables have already been created using create_tables.sql
# To recreate them, run:
docker compose exec -T db psql -U user -d mydb < backend/db/create_tables.sql
```

### Option 2: Using Rails Migrations

```bash
# Using Docker Compose
docker compose exec backend rails db:migrate
```

## Current Status

✅ **Database tables have been created and are ready to use!**

The following tables have been created in the PostgreSQL database:
- `users` - ✅ Created with all indexes
- `user_profiles` - ✅ Created with all indexes and foreign keys
- `work_locations` - ✅ Created with all indexes and foreign keys
- `schema_migrations` - ✅ Created with migration versions
- `ar_internal_metadata` - ✅ Created for Rails metadata

## Database Schema

After running migrations, the schema will include:

- **users**: User authentication
- **user_profiles**: User profile information
- **work_locations**: Daily work location status (office/remote/out_of_office)

## Notes

- The bcrypt gem has been added to the Gemfile for password encryption
- Models have been created in app/models/ with appropriate associations and validations
