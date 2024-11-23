-- CREATE TABLESPACE equivalents:
-- CREATE TABLESPACE emp_tablespace LOCATION '/var/lib/postgresql/data/emp_tablespace';
-- No specific file size or autoextend, as PostgreSQL handles tablespace size based on disk availability

-- CREATE USER equivalents:
CREATE USER scott WITH PASSWORD 'tiger';

-- Same note applies regarding disk size and autoextend

CREATE USER vereinuser WITH PASSWORD 'vereinuser';
ALTER USER vereinuser SET default_tablespace = 'verein_tablespace';
GRANT ALL PRIVILEGES ON TABLESPACE verein_tablespace TO vereinuser;

-- Granting Connect and Resource roles
-- PostgreSQL has no direct equivalent to Oracle's "connect" or "resource" roles. You need to manually define permissions:
GRANT CONNECT ON DATABASE postgres TO scott;
GRANT CONNECT ON DATABASE postgres TO vereinuser;

-- Granting specific privileges for view and materialized view creation:
GRANT CREATE ON SCHEMA public TO scott;
GRANT CREATE ON SCHEMA public TO vereinuser;

-- Granting create materialized view permission (note that materialized views require superuser or certain settings)
GRANT CREATE ON SCHEMA public TO scott;
GRANT CREATE ON SCHEMA public TO vereinuser;
