-- Step 1: Create Roles
CREATE ROLE admin_role;
CREATE ROLE editor_role;
CREATE ROLE viewer_role;

-- Assign permissions to roles
-- Admin Role: Full access
GRANT ALL PRIVILEGES ON SCHEMA public TO admin_role;



-- Editor Role: Read and write
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO editor_role;

-- Viewer Role: Read-only access
GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer_role;

-- Step 2: Create Users and Assign Roles
-- Users from the database
-- Roles assigned randomly

CREATE ROLE dominikmeyer LOGIN PASSWORD 'securepassword1';
GRANT admin_role TO dominikmeyer;

CREATE ROLE petrameyer LOGIN PASSWORD 'securepassword2';
GRANT editor_role TO petrameyer;

CREATE ROLE romygruber LOGIN PASSWORD 'securepassword3';
GRANT viewer_role TO romygruber;


-- Add additional users here
-- Step 3: Ensure Future Permissions Are Applied Automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO viewer_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO editor_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO admin_role;

-- Step 4: Validate Permissions
SELECT r1.rolname AS role_name, r2.rolname AS member_name
FROM pg_roles r1
LEFT JOIN pg_auth_members ON r1.oid = pg_auth_members.roleid
LEFT JOIN pg_roles r2 ON r2.oid = pg_auth_members.member;
