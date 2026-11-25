#!/bin/sh
# Local container only: give the four service logins their DEV passwords from
# infra/.env. Runs once, when the data volume is created.
set -eu

: "${INGEST_SVC_PASSWORD:?missing in infra/.env}"
: "${ML_SVC_PASSWORD:?missing in infra/.env}"
: "${API_SVC_PASSWORD:?missing in infra/.env}"
: "${RAG_SVC_PASSWORD:?missing in infra/.env}"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
  -v ingest_pw="$INGEST_SVC_PASSWORD" \
  -v ml_pw="$ML_SVC_PASSWORD" \
  -v api_pw="$API_SVC_PASSWORD" \
  -v rag_pw="$RAG_SVC_PASSWORD" \
  -f /petria-sql/set-passwords.sql
