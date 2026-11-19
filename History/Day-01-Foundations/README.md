# Day 1: Foundations

Date: 2026-11-19 · Stage 0

## Goal
Decide how the project is organized and set up the first repository, so every
later stage has somewhere to live.

## Decisions
- **Five repositories** instead of a monorepo
  ([ADR-0001](../../docs/adr/0001-polyrepo-and-service-boundaries.md)).
- **One writer per database schema**
  ([ADR-0002](../../docs/adr/0002-one-writer-per-schema.md), still proposed).
- **Public repositories from the first commit**, with a secrets policy
  ([ADR-0003](../../docs/adr/0003-public-repos-and-secrets-policy.md)).
- Docs and the build log live in this repo, `PetrIA`, so the portfolio can
  read them directly.

## What we did
- Created the five repositories: `PetrIA`, `PetrIA-BE`, `PetrIA-RAG`,
  `PetrIA-Ingest`, `PetrIA-ML`.
- Built the structure of `PetrIA` (this repo): project rules for the assistant,
  ignore rules, a security workflow, an environment-variables template, the
  architecture page and the decision records.
- Wrote the roadmap: nine stages, 122 hours.

## What we did not do (and why)
- **No application code.** The Next.js app is Stage 4. Starting it now would
  mean building a map with no data behind it.
- **The other four repos are still empty.** They are set up one at a time, so
  each structure is understood before the next one starts.
- **No database yet.** It is created when `PetrIA-Ingest` first needs it
  (Stage 1).
- **The workflow has not run yet.** It is written and its YAML parses, but a
  GitHub Actions run is the only real test. We check it after the first push.

## Open problems
- The assistant's sandbox cannot reach `datos.gob.ar` (blocked by the network
  policy). Plan: explore the data in Google Colab, or allow the host later.
- Dataset URLs, columns and licenses are still unverified. Nothing about the
  data has been assumed.

## New concepts
Architecture Decision Records, polyrepo vs monorepo, one writer per schema,
least-privilege database roles, secret scanning, static analysis, and why
`NEXT_PUBLIC_` variables must never hold secrets. See
[learning notes](../../docs/learning.md).

## Next
Review the `PetrIA` structure, then set up the other repos one by one.
