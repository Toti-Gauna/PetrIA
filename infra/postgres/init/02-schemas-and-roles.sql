-- PetrIA: four schemas, one writer each (ADR-0002, layout in ADR-0012).
--
-- Building picture: the database is the building, a schema is a room,
-- a GROUP role is a job title (a named list of permissions, cannot log in),
-- a LOGIN role is one service's badge (it gets job titles).
--
-- No passwords here. Logins are created disabled (NOLOGIN); they can connect
-- only after set-passwords.sql gives them a password (local: from .env,
-- Neon: from GitHub secrets).
--
-- Safe to run more than once.

-- 1) Rooms -------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS geo;       -- wells, production (writer: ingest)
CREATE SCHEMA IF NOT EXISTS ml;        -- predictions, model registry (writer: ml)
CREATE SCHEMA IF NOT EXISTS platform;  -- users, saved zones (writer: api)
CREATE SCHEMA IF NOT EXISTS rag;       -- document chunks (writer: rag)

-- 2) Job titles (groups) and badges (logins) ---------------------------------
DO $$
DECLARE r text;
BEGIN
  FOREACH r IN ARRAY ARRAY[
    'geo_writer', 'geo_reader', 'ml_writer', 'ml_reader',
    'platform_writer', 'rag_writer',
    'ingest_svc', 'ml_svc', 'api_svc', 'rag_svc'
  ] LOOP
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = r) THEN
      EXECUTE format('CREATE ROLE %I NOLOGIN', r);
    END IF;
  END LOOP;
END $$;

-- 3) What each job title may do ----------------------------------------------
-- USAGE = the door opens. CREATE = may create tables in the room.
-- SELECT = may read the tables. Everything else is denied by default.
GRANT USAGE, CREATE ON SCHEMA geo      TO geo_writer;
GRANT USAGE         ON SCHEMA geo      TO geo_reader;
GRANT USAGE, CREATE ON SCHEMA ml       TO ml_writer;
GRANT USAGE         ON SCHEMA ml       TO ml_reader;
GRANT USAGE, CREATE ON SCHEMA platform TO platform_writer;
GRANT USAGE, CREATE ON SCHEMA rag      TO rag_writer;

-- Tables that already exist today:
GRANT SELECT ON ALL TABLES IN SCHEMA geo TO geo_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA ml  TO ml_reader;

-- 4) Who has which job title (ADR-0002) --------------------------------------
GRANT geo_writer                                TO ingest_svc;
GRANT geo_reader, ml_writer                     TO ml_svc;
GRANT geo_reader, ml_reader, platform_writer    TO api_svc;
GRANT geo_reader, ml_reader, rag_writer         TO rag_svc;

-- 5) The admin may act as each service ---------------------------------------
-- Needed so the admin can set default privileges FOR a service (step 6) and
-- run the role tests with SET ROLE. A local superuser does not need it; on
-- Neon the admin is not a superuser (to be confirmed by the Neon run).
GRANT ingest_svc, ml_svc, api_svc, rag_svc TO CURRENT_USER;

-- 6) Tables created LATER ----------------------------------------------------
-- "GRANT ... ON ALL TABLES" only covers tables that exist now. These rules
-- cover future tables. They fire for tables created by the named LOGIN (the
-- creator), so services must create their own tables, never the admin.
ALTER DEFAULT PRIVILEGES FOR ROLE ingest_svc IN SCHEMA geo
  GRANT SELECT ON TABLES TO geo_reader;
ALTER DEFAULT PRIVILEGES FOR ROLE ml_svc IN SCHEMA ml
  GRANT SELECT ON TABLES TO ml_reader;
