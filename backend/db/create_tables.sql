-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password_digest VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS index_users_on_username ON users(username);

-- Create employee_profiles table
CREATE TABLE IF NOT EXISTS employee_profiles (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_employee_profiles_user
        FOREIGN KEY(user_id) 
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS index_employee_profiles_on_user_id ON employee_profiles(user_id);

-- Create work_locations table
CREATE TABLE IF NOT EXISTS work_locations (
    id BIGSERIAL PRIMARY KEY,
    employee_profile_id BIGINT NOT NULL,
    status VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_work_locations_employee_profile
        FOREIGN KEY(employee_profile_id) 
        REFERENCES employee_profiles(id)
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS index_work_locations_on_employee_profile_id ON work_locations(employee_profile_id);
CREATE INDEX IF NOT EXISTS index_work_locations_on_date ON work_locations(date);
CREATE UNIQUE INDEX IF NOT EXISTS index_work_locations_on_employee_profile_id_and_date ON work_locations(employee_profile_id, date);
