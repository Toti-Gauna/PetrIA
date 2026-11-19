# 0002. One writer per database schema

Status: Accepted (2026-11-19)

## Context
Four services share one Postgres database (Neon, with PostGIS and pgvector).
Letting every service write every table makes it impossible to say who is
responsible for what, and one buggy service could corrupt another's data.
The AI assistant also runs model-generated SQL, so what it may touch must be
limited by the database itself, not only by application code.

## Options
A. **One shared schema**, every service has full access. Simple, but no
   ownership and no safety net.
B. **One schema per writer.** Each service owns exactly one schema and gets
   read-only access to the others it needs (chosen).
C. **One database per service.** Strongest isolation, but cross-service
   queries (for example a map joining wells and predictions) become API calls
   or copies, and it costs more to run.

## Decision
Option B: four schemas, each with a single writer role.

| Schema | Writer | Readers |
|---|---|---|
| `geo` | PetrIA-Ingest | ML, BE, RAG |
| `ml` | PetrIA-ML | BE, RAG |
| `rag` | PetrIA-RAG | RAG |
| `platform` | PetrIA-BE (Flyway migrations) | BE |

Readers connect with read-only roles. The assistant's SQL tool uses a
read-only role *and* an allowlist.

## Consequences
+ Clear ownership; a bug in one service cannot corrupt another's tables.
+ A prompt-injected or badly generated query cannot modify data.
- More roles and grants to create and keep in sync.
- Cross-schema reads create coupling to table shapes. Changing a table in
  `geo` means checking its readers.
- Neon limits and role setup must be checked when the database is created
  (Stage 1).

Note: this was refined from an earlier "two schemas" idea (geo and platform)
once it was clear that the detector and the assistant also write data. The
project owner confirmed it on 2026-11-19, after checking with a throwaway
Postgres that a read-only role gets `permission denied` on writes.
