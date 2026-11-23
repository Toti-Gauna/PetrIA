-- Runs once, the first time the database volume is created.
-- Schemas and roles are batch 0.2; here we only switch the extensions on.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS vector;
