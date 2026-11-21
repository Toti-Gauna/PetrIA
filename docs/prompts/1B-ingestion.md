# Build prompt 1B: Ingestion

**Run with:** Sonnet 5.5, effort medium · **Planned:** 13 h · **Repo:** `PetrIA-Ingest`
**Before you paste this:** the notebook run 3 report is in `docs/data-sources.md`, and you have seen the 1B lesson in the Learning Pack.

---

You are the builder for batch 1B of PetrIA. Work in the `PetrIA-Ingest` repo on the branch the session names. Never push to main.

## Read first (do not skip)
1. `CLAUDE.md` of this repo and `docs/roadmap.md` (batch 1B).
2. `docs/data-sources.md`: the verified facts about the six files (columns, keys, fingerprints, known problems). Trust this file over any research note. If a fact you need is marked unverified, say so and ask.
3. ADR-0002 (one writer per schema) and ADR-0005 (data license unconfirmed).

## Goal
A Python worker that downloads nothing by itself from the cloud (see decision 2), reads the six official files, cleans them without inventing values, and loads them into Postgres/PostGIS schema `geo` on Neon. Running it twice must give the same database.

## Step 1: the spec, then STOP
Write `docs/specs/1B-ingestion.md` using the template in the PetrIA repo (`docs/specs/README.md`). Include two decisions, each with two options, pros and cons, and your recommendation:
- **Decision 1, data model.** Option A: one table by `idpozo` (a well in one formation). Option B: a physical-well table by `sigla` plus a well-and-formation table. Use the run 3 numbers about repeated names to argue.
- **Decision 2, how files reach the cloud.** Option A: the cloud worker downloads from the portal (it was blocked in tests). Option B: the owner downloads at home, uploads to cloud storage, the worker loads from there. Recommend based on `docs/data-sources.md`.

Then stop and wait for the owner to answer. Do not write code before the answer.

## Step 2: build (after the owner approves)
Small steps, each with a test, each explained in plain words:
1. Migrations (plain SQL files, numbered) for schemas `geo` and roles: `ingest_rw` owns `geo`; `ml_ro`, `rag_ro` and `platform_ro` get `USAGE` and `SELECT` only. Test with a throwaway database that a read-only role gets `permission denied` on `INSERT`.
2. Readers: one function per file. Handle the decimal comma, text numbers, and the encoding the verification found. Keep the original raw value next to any fixed value.
3. Cleaning rules, each one a small tested function and each one logged:
   - swapped latitude/longitude: use the sanity box (lon -74..-53, lat -56..-21); swap only when swapping lands inside the box; otherwise mark the point invalid and keep it.
   - left-censoring: add a flag `start_censored` for wells whose first production month is the first month of the dataset.
   - never fill a missing value; store `NULL` and count it.
4. **Algorithm spot: hash-map well index (no-AI).** STOP here. Describe the problem (find a well by `idpozo` in O(1) while loading, instead of scanning a list), expected complexity (O(n) build, O(1) lookup) and write 3 failing tests. The owner writes the function by hand. You review it. Do not write it yourself.
5. Idempotent load: load in a transaction, upsert by natural key, record each file's SHA-256 in a `geo.load_log` table; skip a file already loaded with the same hash.
6. A command-line entry point: `python -m petria_ingest load --source <folder>` and a `--dry-run` that prints counts and problems without writing.
7. A data-quality report (Markdown) generated after each load: rows read, rows loaded, rows rejected and why, swapped points fixed, nulls per column.
8. A Colab runner notebook in `notebooks/` that reads the Neon connection string from Colab Secrets (never typed into a cell, never committed) and runs the same code.
9. Monthly job stub: a RabbitMQ consumer is out of scope for now; leave a documented function `load_month()` and a `TODO` in the spec.

## Rules
- No secrets in the repo; add `.env.example` only.
- Never invent a column, a unit or a value. If something is unverified, put it in the report as a question.
- Public repo: no personal data.
- Tests: pytest. Run them before every commit. CI must stay green (Semgrep, gitleaks).
- One commit per step; clear messages.

## Done when
- `pytest` passes, including idempotency (load twice, same counts) and the read-only role test.
- `python -m petria_ingest load --dry-run` prints counts that match `docs/data-sources.md` within the explained differences.
- The quality report exists and every rejected row has a reason.
- `docs/learning.md` has a new entry: what, why, new concepts, 4 interview questions with short answers, and the hash-map spot under "Algorithms used in production".

## Close the batch
Per the repo's `teach-back` and `handoff` skills: 1–3 break-it experiments (ask the owner to predict first), an explain-back, then a pull request for the owner's written review. Do not merge. Finish by announcing the next batch: 1C, Opus 5.5, effort high.
