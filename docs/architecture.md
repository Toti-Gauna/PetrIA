# Architecture

> **Status: design.** Nothing here is implemented yet. This page changes as
> each stage is built, and every change of direction gets an
> [ADR](adr/README.md).

## Overview

```
                    ┌──────────────┐
   Browser ───────▶ │  PetrIA web  │  Next.js + MapLibre GL
                    └──────┬───────┘
                           │ HTTPS + OIDC token
                    ┌──────▼───────┐        ┌──────────┐
                    │  PetrIA-BE   │◀──────▶│ Keycloak │
                    └───┬──────┬───┘        └──────────┘
          reads geo, ml │      │ HTTP
        owns platform   │      ▼
                        │  ┌────────────┐       ┌────────────┐
                        │  │ PetrIA-RAG │──────▶│ Claude API │
                        │  └─────┬──────┘       └────────────┘
                        │        │ reads geo, ml
                        │        │ owns rag
                  ┌─────▼────────▼──────────────────┐
                  │ Postgres (Neon): PostGIS + pgvector │
                  │ schemas:  geo | ml | rag | platform │
                  └─────▲───────────────────▲────────┘
                  writes│ geo               │ writes ml
                 ┌──────┴────────┐    ┌─────┴───────┐
                 │ PetrIA-Ingest │    │  PetrIA-ML  │
                 └──────▲────────┘    └─────────────┘
                        │ monthly update message
                    RabbitMQ
```

A gateway (Spring Cloud Gateway) may sit between the web app and the backend.
It is an optional extra, not part of the first version.

## Services

| Service | Responsibility | Talks to |
|---|---|---|
| PetrIA (web) | Map, layers, well and cell detail, chat panel | PetrIA-BE |
| PetrIA-BE | Users, organizations, saved zones, query history; serves geo and detector data; authenticates requests | Keycloak, Postgres, PetrIA-RAG |
| PetrIA-RAG | Answers questions with tools and retrieval; cites sources; abstains without evidence | Postgres, Claude API |
| PetrIA-Ingest | Downloads, cleans and loads the official data; idempotent monthly updates | Data portal, Postgres, RabbitMQ |
| PetrIA-ML | Trains the detector and writes predictions on a hexagonal grid | Postgres |

## Data ownership

One database, four schemas, **one writer per schema**
(see [ADR-0002](adr/0002-one-writer-per-schema.md)):

| Schema | Written by | Read by | Content |
|---|---|---|---|
| `geo` | PetrIA-Ingest | ML, BE, RAG | Wells, production, fracturing, concessions |
| `ml` | PetrIA-ML | BE, RAG | Predictions, hex grid, model registry |
| `rag` | PetrIA-RAG | RAG | Document chunks and embeddings |
| `platform` | PetrIA-BE | BE | Users, organizations, saved zones, history |

## Trust boundaries

- The browser never talks to the database, the assistant or Claude directly.
- Authentication happens once, in PetrIA-BE, using OIDC tokens from Keycloak.
- The assistant's SQL tool runs under a **read-only** database role and an
  allowlist, so even a bad generated query cannot change data.
- Secrets live in GitHub Actions secrets (CI) and Render environment variables
  (runtime). Never in the repositories
  ([ADR-0003](adr/0003-public-repos-and-secrets-policy.md)).

## Contracts between services

- **OpenAPI** is generated from the code of each producer (PetrIA-BE, PetrIA-RAG).
- **Pact** consumer-driven tests between web and BE, and between BE and RAG.
  Pact files go to a broker, not to a shared repository
  ([ADR-0001](adr/0001-polyrepo-and-service-boundaries.md)).

## What the product does and does not claim

PetrIA estimates *expected* productivity from existing wells. It does not
find oil, and the interface says so.
