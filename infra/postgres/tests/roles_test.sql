-- Role tests: does the wall hold? Run as the admin.
-- Everything happens inside one transaction and is ROLLED BACK at the end,
-- so it leaves nothing behind (safe to run on Neon too).
--
-- expect_denied(role, sql): passes ONLY if Postgres refuses with
--   insufficient_privilege (SQLSTATE 42501). If the statement works, or fails
--   for another reason (a typo), the test FAILS.
-- expect_allowed(role, sql): passes only if the statement works.

\set ON_ERROR_STOP on
\set VERBOSITY terse
BEGIN;

CREATE FUNCTION pg_temp.expect_denied(r text, q text) RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
  EXECUTE format('SET ROLE %I', r);
  BEGIN
    EXECUTE q;
  EXCEPTION WHEN insufficient_privilege THEN
    RESET ROLE;
    RAISE NOTICE 'ok   denied : % -> %', r, q;
    RETURN;
  END;
  RESET ROLE;
  RAISE EXCEPTION 'FAIL: % was ALLOWED to run: %', r, q;
END $$;

CREATE FUNCTION pg_temp.expect_allowed(r text, q text) RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
  EXECUTE format('SET ROLE %I', r);
  BEGIN
    EXECUTE q;
  EXCEPTION WHEN OTHERS THEN
    RESET ROLE;
    RAISE EXCEPTION 'FAIL: % could not run [%]: %', r, q, SQLERRM;
  END;
  RESET ROLE;
  RAISE NOTICE 'ok   allowed: % -> %', r, q;
END $$;

-- Setup: each writer creates one probe table in its own room, AFTER the
-- grants ran. So readers can only see them thanks to default privileges.
SET ROLE ingest_svc; CREATE TABLE geo.roles_probe (id int); INSERT INTO geo.roles_probe VALUES (1); RESET ROLE;
SET ROLE ml_svc;     CREATE TABLE ml.roles_probe  (id int); RESET ROLE;
SET ROLE api_svc;    CREATE TABLE platform.roles_probe (id int); RESET ROLE;
SET ROLE rag_svc;    CREATE TABLE rag.roles_probe (id int); RESET ROLE;

-- A role with no job title at all.
CREATE ROLE roles_probe_nobody NOLOGIN;
GRANT roles_probe_nobody TO CURRENT_USER;

DO $$ BEGIN
  -- 1. The headline: ML cannot write into geo.
  PERFORM pg_temp.expect_denied ('ml_svc',  'INSERT INTO geo.roles_probe VALUES (2)');
  PERFORM pg_temp.expect_denied ('ml_svc',  'CREATE TABLE geo.ml_was_here (id int)');

  -- 2. ML reads geo and writes its own room.
  PERFORM pg_temp.expect_allowed('ml_svc',  'SELECT * FROM geo.roles_probe');
  PERFORM pg_temp.expect_allowed('ml_svc',  'INSERT INTO ml.roles_probe VALUES (1)');

  -- 3. API: reads geo and ml, writes only platform.
  PERFORM pg_temp.expect_allowed('api_svc', 'SELECT * FROM geo.roles_probe');
  PERFORM pg_temp.expect_allowed('api_svc', 'SELECT * FROM ml.roles_probe');
  PERFORM pg_temp.expect_denied ('api_svc', 'INSERT INTO geo.roles_probe VALUES (3)');
  PERFORM pg_temp.expect_denied ('api_svc', 'INSERT INTO ml.roles_probe VALUES (3)');
  PERFORM pg_temp.expect_allowed('api_svc', 'INSERT INTO platform.roles_probe VALUES (1)');
  PERFORM pg_temp.expect_denied ('api_svc', 'SELECT * FROM rag.roles_probe');

  -- 3b. RAG (runs AI-written SQL): reads geo and ml, writes only rag.
  PERFORM pg_temp.expect_allowed('rag_svc', 'SELECT * FROM geo.roles_probe');
  PERFORM pg_temp.expect_allowed('rag_svc', 'SELECT * FROM ml.roles_probe');
  PERFORM pg_temp.expect_denied ('rag_svc', 'INSERT INTO geo.roles_probe VALUES (4)');
  PERFORM pg_temp.expect_denied ('rag_svc', 'UPDATE ml.roles_probe SET id = 0');
  PERFORM pg_temp.expect_allowed('rag_svc', 'INSERT INTO rag.roles_probe VALUES (1)');
  PERFORM pg_temp.expect_denied ('rag_svc', 'SELECT * FROM platform.roles_probe');

  -- 4. Ingest writes geo only.
  PERFORM pg_temp.expect_allowed('ingest_svc', 'INSERT INTO geo.roles_probe VALUES (5)');
  PERFORM pg_temp.expect_denied ('ingest_svc', 'INSERT INTO ml.roles_probe VALUES (5)');

  -- 5. No job title: every door is locked.
  PERFORM pg_temp.expect_denied ('roles_probe_nobody', 'SELECT * FROM geo.roles_probe');
  PERFORM pg_temp.expect_denied ('roles_probe_nobody', 'SELECT * FROM ml.roles_probe');

  -- 6. A reader can never destroy another room's data.
  PERFORM pg_temp.expect_denied ('rag_svc', 'DROP TABLE geo.roles_probe');
  PERFORM pg_temp.expect_denied ('rag_svc', 'TRUNCATE geo.roles_probe');
  PERFORM pg_temp.expect_denied ('ml_svc',  'DELETE FROM geo.roles_probe');
END $$;

DO $$ BEGIN RAISE NOTICE 'ALL ROLE TESTS PASSED'; END $$;

ROLLBACK;
