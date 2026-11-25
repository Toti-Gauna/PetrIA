-- Turns the four service badges on: LOGIN + a password.
-- The passwords come in as psql variables, never written in this file:
--   psql -v ingest_pw=... -v ml_pw=... -v api_pw=... -v rag_pw=... -f set-passwords.sql
-- Local: values from infra/.env. Neon: values from GitHub secrets.

-- Keep error output short, so a failing statement is not echoed with its text.
\set VERBOSITY terse

ALTER ROLE ingest_svc WITH LOGIN PASSWORD :'ingest_pw';
ALTER ROLE ml_svc     WITH LOGIN PASSWORD :'ml_pw';
ALTER ROLE api_svc    WITH LOGIN PASSWORD :'api_pw';
ALTER ROLE rag_svc    WITH LOGIN PASSWORD :'rag_pw';
