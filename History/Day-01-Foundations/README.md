# Day 1: Foundations

Date: 2026-11-19 · Stage 0

## Goal
Decide how the project is organized and set up the first repository, so every
later stage has somewhere to live.

## Decisions
- **Five repositories** instead of a monorepo
  ([ADR-0001](../../docs/adr/0001-polyrepo-and-service-boundaries.md)).
- **One writer per database schema**
  ([ADR-0002](../../docs/adr/0002-one-writer-per-schema.md), accepted after
  a hands-on check with a throwaway Postgres).
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
- Merged the `PetrIA` foundations into `main` through a pull request.
- Rolled out the same skeleton (project rules, README, ignore rules,
  environment template, security workflow, Dependabot) to the other four
  repositories. The files were reused from `PetrIA`, so the fixed workflow
  (pinned actions, cooldown) went out from the start. CI passed on all four.
- Verified, with a throwaway Postgres and toy data, how roles and grants stop
  a read-only service from writing. A role with no grants gets
  `permission denied for schema`; after `USAGE` it gets
  `permission denied for table`; after `SELECT` it can read and still cannot
  write.
- Closed the stage with an explain-back: why one writer per schema, and who
  enforces it (the database, through roles, not the application).

## What we did not do (and why)
- **No application code.** The Next.js app is Stage 4. Starting it now would
  mean building a map with no data behind it.
- **No real code structure in the other four repos.** They only got the same
  shared skeleton. Their language-specific layout, tests and tooling (Java
  packages and JUnit, Python packages and pytest) are explained when each
  repo's stage starts.
- **No database yet.** It is created when `PetrIA-Ingest` first needs it
  (Stage 1).
- **Nothing was assumed about the workflow.** It was only tested by pushing it.

## First CI run (real result)
- gitleaks: passed, no secrets found.
- Semgrep: **failed with 4 findings**, all in our own CI configuration:
  three GitHub Actions referenced by a mutable tag (`@v4`, `@v2`) and a
  Dependabot config without a cooldown.
- Fix: pin every action to a full commit SHA (version kept in a comment) and
  add `cooldown: default-days: 7` to Dependabot. The SHAs were read from the
  actions' public repositories, not guessed. Why it matters: a tag can be
  moved by the action's owner, a commit SHA cannot.
- Second run, after the fix: both jobs passed.

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
Stage 1, data. Day 2 is research only: exploring the Vaca Muerta datasets in
a Colab notebook, verifying every URL, column and license, and writing a
data-quality report. No loader code and no database yet.
