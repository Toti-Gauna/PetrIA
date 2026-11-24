# Postgres with BOTH extensions PetrIA needs:
#   PostGIS  -> map queries (wells near a point, points inside a concession)
#   pgvector -> search documents by meaning (the assistant)
# The ready-made images carry one or the other, so we start from the PostGIS
# image and add pgvector on top.
#
# The tag is pinned on purpose (never "latest"): the package name below
# contains the Postgres major version (16), so the base must not move by itself.
# Dependabot proposes a new base as a pull request.
# Neon's Postgres version is compared with this one in batch 0.2.
#
# Why not 16-3.4: CI showed it is built on Debian bullseye, whose PostgreSQL
# package repository now answers 404, so pgvector cannot be installed. Pick a
# base on a Debian release that is still supported.
FROM postgis/postgis:18-3.6

RUN apt-get update \
 && apt-get install -y --no-install-recommends postgresql-16-pgvector \
 && rm -rf /var/lib/apt/lists/*

# Scripts in this folder run once, when the data folder is empty.
COPY init/ /docker-entrypoint-initdb.d/
