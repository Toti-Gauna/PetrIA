# 0012. Database roles: job-title groups, one login per service

Status: Accepted (2026-11-25)

## Context
[ADR-0002](0002-one-writer-per-schema.md) decided four schemas with one writer
each (`geo`, `ml`, `platform`, `rag`). This ADR decides how the roles are laid
out, where the setup lives, and how it reaches Neon. The assistant runs
model-generated SQL, so the database must refuse what the code should never do.

## Options
A. **One login per service, permissions granted directly to each login.**
   Simple, but every reader repeats the same grants, and a forgotten grant is a
   bug that appears later.
B. **Group roles as "job titles" (a named list of permissions, no login), and one
   login per service that is a member of its groups** (chosen).
C. **Every service uses the Neon admin.** No protection at all: one bug or one
   prompt injection could drop every table.

## Decision
Option B.

| Login | Groups | Writes | Reads |
|---|---|---|---|
| `ingest_svc` | `geo_writer` | `geo` | `geo` |
| `ml_svc` | `geo_reader`, `ml_writer` | `ml` | `geo`, `ml` |
| `api_svc` | `geo_reader`, `ml_reader`, `platform_writer` | `platform` | `geo`, `ml`, `platform` |
| `rag_svc` | `geo_reader`, `ml_reader`, `rag_writer` | `rag` | `geo`, `ml`, `rag` |

Rules:
- The setup is code: `infra/postgres/init/02-schemas-and-roles.sql`. The same
  file builds the local container and Neon, so they cannot drift apart.
- No passwords in the repo. Logins are created disabled (`NOLOGIN`) and only get
  `LOGIN` plus a password from `set-passwords.sql`: dev values from `infra/.env`
  locally, GitHub secrets on Neon (manual `neon` workflow).
- Future tables: `ALTER DEFAULT PRIVILEGES FOR ROLE <creating login>`. The rule
  fires for the **creator**, so each service creates its own tables; tables are
  never created as the admin.
- The admin is a member of the four logins, so it can set those default
  privileges and run the tests with `SET ROLE` even when it is not a superuser.
- `infra/postgres/tests/roles_test.sql` proves the wall: forbidden actions must
  fail with `insufficient_privilege` (SQLSTATE 42501), allowed ones must work. It
  runs in CI on every push and in the Neon workflow, inside a rolled-back
  transaction.

## Consequences
+ A bug or an injected query in one service cannot change another's data; the
  database refuses, and a test shows it.
+ A new reader is one line: `GRANT geo_reader TO new_svc;`.
- Tables are owned by the service login. Replacing a login later needs
  `REASSIGN OWNED`.
- Workflow logs of a public repo are public: the Neon workflow never prints the
  host, the connection string or a password.

## Verified on Neon (2026-11-25, first `neon` run)
- Postgres **18.7**. The admin is `superuser=false createrole=true`.
- Every statement of the setup ran with that admin, including the default
  privileges and `SET ROLE` in the tests.
- All 23 role checks passed (rolled back), and the four service logins
  connected with their own passwords.
- Local was on Postgres 16, so the local image moved to `postgis/postgis:18-3.6`
  with `postgresql-18-pgvector`, to keep local and cloud on the same major
  version.
