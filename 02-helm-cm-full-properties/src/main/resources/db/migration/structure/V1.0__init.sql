CREATE SCHEMA IF NOT EXISTS helmcm;

SET search_path TO helmcm;

CREATE TABLE IF NOT EXISTS t_users
(
    id SERIAL PRIMARY KEY, -- Auto-incremental ID
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    age INTEGER
);