# Postgres with BOTH extensions PetrIA needs:
#   PostGIS  -> map queries (wells near a point, points inside a concession)
#   pgvector -> search documents by meaning (the assistant)
# The ready-made images carry one or the other, so we start from the PostGIS
# image and add pgvector on top.
#
# The tag is pinned on purpose (never "latest"): the package name below
# contains the Postgres major version (18), so the base must not move by itself.
# Dependabot proposes a new base as a pull request.
#
# Major version 18 matches Neon (the cloud database runs 18.7, read by the
# neon workflow on 2026-11-25). Keep local and cloud on the same major version.
#
# History: 16-3.4 failed (Debian bullseye, PostgreSQL apt repo answers 404);
# 16-3.6 worked; moved to 18 to match Neon (ADR-0012).
FROM postgis/postgis:18-3.6

RUN apt-get update \
 && apt-get install -y --no-install-recommends postgresql-18-pgvector \
 && rm -rf /var/lib/apt/lists/*

# Scripts in this folder run once, when the data folder is empty:
# 01 extensions, 02 schemas and roles, 03 local dev passwords.
COPY init/ /docker-entrypoint-initdb.d/
# Shared SQL used by the init scripts (and by the Neon workflow from the repo).
COPY sql/ /petria-sql/
