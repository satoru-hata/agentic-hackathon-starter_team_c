# Employee Work Location System Specification

## Overview
Employee work location management system. Employees can register, login, register their information and work location, and view the work location status of other employees in a list.

## Features
1. **Authentication**
   - User registration
   - Login
   - Logout

2. **Profile Management**
   - Register/edit personal information
   - Update work location status

3. **List Display**
   - Display all employees' work location status
   - Real-time status updates

## Database Design

### users table
User authentication information management

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | bigint | PRIMARY KEY, AUTO_INCREMENT | User ID |
| username | string | NOT NULL, UNIQUE, INDEX | Username (for login) |
| password_digest | string | NOT NULL | Password (encrypted) |
| created_at | datetime | NOT NULL | Creation date |
| updated_at | datetime | NOT NULL | Update date |

### employee_profiles table
Employee profile information management

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | bigint | PRIMARY KEY, AUTO_INCREMENT | Profile ID |
| user_id | bigint | NOT NULL, UNIQUE, FOREIGN KEY | User ID |
| name | string | NOT NULL | Employee name (for display) |
| department | string | NOT NULL | Department |
| created_at | datetime | NOT NULL | Creation date |
| updated_at | datetime | NOT NULL | Update date |

### work_locations table
Work location history management

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | bigint | PRIMARY KEY, AUTO_INCREMENT | Work location ID |
| employee_profile_id | bigint | NOT NULL, FOREIGN KEY, INDEX | Employee profile ID |
| status | string | NOT NULL | Work location status (office/remote/out_of_office) |
| date | date | NOT NULL, INDEX | Date |
| created_at | datetime | NOT NULL | Creation date |
| updated_at | datetime | NOT NULL | Update date |

**Indexes:**
- UNIQUE INDEX on (employee_profile_id, date) - One record per day

### Status Options
- `office`: Working at office
- `remote`: Remote work  
- `out_of_office`: Out/Vacation

## API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - Login
- `DELETE /api/v1/auth/logout` - Logout
- `GET /api/v1/auth/current_user` - Get current user information

### Employee Profile
- `GET /api/v1/profile` - Get own profile
- `POST /api/v1/profile` - Create profile
- `PUT /api/v1/profile` - Update profile

### Work Location
- `GET /api/v1/work_locations/today` - Today's all employee work locations list
- `POST /api/v1/work_locations` - Register today's work location
- `PUT /api/v1/work_locations/:id` - Update work location
- `GET /api/v1/work_locations/history` - Own work location history

## Request/Response Examples

### Register
**Request:**
```json
POST /api/v1/auth/register
{
  "username": "tanaka.taro",
  "password": "password123"
}
```

**Response:**
```json
{
  "id": 1,
  "username": "tanaka.taro",
  "token": "jwt_token_here"
}
```

### Create Profile
**Request:**
```json
POST /api/v1/profile
{
  "name": "Taro Tanaka",
  "department": "Development"
}
```

### Update Today's Work Location
**Request:**
```json
POST /api/v1/work_locations
{
  "status": "office"
}
```

### Get Today's Work Locations List
**Response:**
```json
{
  "work_locations": [
    {
      "id": 1,
      "name": "Taro Tanaka",
      "department": "Development",
      "status": "office",
      "date": "2025-12-12"
    },
    {
      "id": 2,
      "name": "Hanako Yamada",
      "department": "Sales",
      "status": "remote",
      "date": "2025-12-12"
    }
  ]
}
```

## Technical Stack
- Backend: Ruby on Rails (API mode)
- Database: PostgreSQL
- Frontend: React with TypeScript
- Authentication: JWT tokens
- Styling: Tailwind CSS