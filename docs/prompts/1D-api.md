# Build prompt 1D: Read-only API

**Run with:** Sonnet 5.5, effort medium · **Planned:** 6 h · **Repo:** `PetrIA-BE`
**Before you paste this:** `geo` and `ml` have data. You have seen the 1D lesson (API, OpenAPI, read-only role) in the Learning Pack.

---

You are the builder for batch 1D of PetrIA: the read-only API. Work in the `PetrIA-BE` repo on the branch the session names. Never push to main.

## Step 0: create the agent
Create `.claude/agents/petria-backend.md` in the PetrIA repo style (see `petria-data-ml.md`): role, tools, `model: sonnet`, rules (Java 21, Spring Boot, never write to `geo` or `ml`, every query scoped by organization once tenants exist). Show it to the owner and wait for OK before continuing.

## Read first
`CLAUDE.md` of this repo, `docs/roadmap.md` (1D), ADR-0002, and the table definitions in `PetrIA-Ingest` (`geo`) and `PetrIA-ML` (`ml`).

## Step 1: the spec, then STOP
Write `docs/specs/1D-api.md` with: the endpoints, the JSON shape of each, paging, errors, the database role used (`platform_ro` reads `geo` and `ml`; `platform_rw` owns `platform`), and non-goals (no login yet: that is 1.1). Endpoints to propose:
- `GET /api/wells?bbox=` wells inside a map rectangle (limit, cursor);
- `GET /api/wells/{idpozo}` one well with its monthly production;
- `GET /api/cells?bbox=` predicted cells with P10, P50, P90 and a confidence flag;
- `GET /api/cells/{h3}` one cell;
- `GET /api/concessions` polygons as GeoJSON (simplified);
- `GET /api/health`.
Stop and wait for the owner's OK.

## Step 2: build
1. Spring Boot project (Java 21), Flyway for the `platform` schema only, springdoc OpenAPI at `/v3/api-docs`.
2. Two data sources: read-only for `geo` and `ml`; the app must fail to start if the read-only role can write (a startup check that tries and expects `permission denied`).
3. One controller per resource, a service layer, plain SQL or JPA projections (justify the choice in one paragraph).
4. Input validation (bbox limits, page size cap) and clear error JSON.
5. Tests: JUnit + Testcontainers with PostGIS. At least: a bbox query returns only wells inside; a write attempt through the read-only role fails; the OpenAPI document contains every endpoint.
6. `docs/api.md`: how to run, how to call each endpoint with `curl`.

## Rules
No secrets in the repo; `.env.example` only. Public repo. Keep CI green. Explain every technical word in plain language the first time it appears.

## Done when
`./mvnw verify` passes; the OpenAPI file is exported to `docs/openapi.json`; the owner can open `/swagger-ui` locally and call two endpoints.

## Close the batch
`teach-back` and `handoff`; break-it (for example, point the app at the owner role and predict what the startup check does); explain-back; pull request, no merge. Announce 1E: Fable 5.2, effort high; the owner should open a Fable session for it.
