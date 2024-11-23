-- Create the user for the emp-dept application
CREATE USER scott WITH PASSWORD 'tiger';
CREATE SCHEMA emp_schema AUTHORIZATION scott;

-- Create the user for the verein application
CREATE USER vereinuser WITH PASSWORD 'vereinuser';
CREATE SCHEMA verein_schema AUTHORIZATION vereinuser;

-- Grant privileges
GRANT CONNECT ON DATABASE your_database TO scott;
GRANT CONNECT ON DATABASE your_database TO vereinuser;

GRANT CREATE ON SCHEMA emp_schema TO scott;
GRANT CREATE ON SCHEMA verein_schema TO vereinuser;

GRANT CREATE VIEW ON SCHEMA emp_schema TO scott;
GRANT CREATE VIEW ON SCHEMA verein_schema TO vereinuser;

GRANT CREATE MATERIALIZED VIEW ON SCHEMA emp_schema TO scott;
GRANT CREATE MATERIALIZED VIEW ON SCHEMA verein_schema TO vereinuser;