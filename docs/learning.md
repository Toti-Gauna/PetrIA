# Learning notes

What we learned, why it matters, and interview questions with short answers.
One section per day.

## Day 1: Foundations

### Concepts

**ADR (Architecture Decision Record).** A short, immutable file recording one
decision: context, options, choice, consequences. A commit says *what*
changed; an ADR says *why*, and what we rejected.

**Polyrepo vs monorepo.** Both are valid. Monorepo: one CI, atomic
cross-service changes. Polyrepo: independent deploys and clear boundaries, but
duplicated CI and coordination across repos. Contracts between services then
become a real need.

**One writer per schema.** Each service owns one database schema and has
read-only access to the others. In SQL Server terms: schemas (like `dbo`) and
logins/users with `GRANT SELECT`. Same ideas, applied across services.

**Least privilege.** A service gets only the permissions it needs. The
assistant executes model-generated SQL, so the *database* (a read-only role)
must stop writes, not just the application code.

**Secret scanning (gitleaks).** Searches commits for things that look like
keys and tokens. Runs after the push, so it is a safety net.

**Static analysis (Semgrep).** Reads source code for risky patterns (injection,
unsafe deserialization) without running it. gitleaks looks for *leaked values*;
Semgrep looks for *dangerous code*.

**`NEXT_PUBLIC_` variables.** Next.js inlines them into the JavaScript sent to
the browser. They are public by design.

**Docker, image, container.** An *image* is a frozen, read-only package of an
app and everything it needs, built from a `Dockerfile`. A *container* is a
running, isolated instance of an image (class vs object). Nothing is installed
on the host. In our CI, GitHub starts a container from `semgrep/semgrep` and
removes it when the job ends.

**Supply-chain pinning.** A tag such as `actions/checkout@v4` is a label the
owner can move. A full commit SHA is a fingerprint that cannot change. Pinning
makes builds reproducible and blocks a silent swap of the code that runs in
our CI. Updates are still possible: Dependabot proposes a new SHA as a pull
request, and we choose when to merge it.

**Dependabot cooldown.** Wait N days (we use 7) before proposing a new
release. Malicious releases are usually detected and removed within days. It
reduces the risk; it does not remove it.

**Postgres roles and grants.** A role is an identity in the database; a role
with `LOGIN` is what a service connects as (the username in its connection
string). Permissions are layered and **denied by default**: `USAGE` on the
schema (can enter), then `SELECT`/`INSERT`/`UPDATE`/`DELETE` on each table,
and ownership for structure changes (`DROP`, `ALTER`). In SQL Server terms:
login + user + `GRANT`, but Postgres merges login, user and role into one
thing. We verified it on a throwaway database: a role with no grants gets
`permission denied for schema`; after `USAGE` it gets `permission denied for
table`; after `SELECT` it can read, and still cannot write.

### Interview questions

1. **Why five repositories instead of a monorepo?**
   Services deploy independently and have different languages. It also forces
   explicit contracts (OpenAPI, Pact). The price is duplicated CI and
   cross-repo coordination. A monorepo would have been a valid choice too.

2. **Why are ADRs immutable?**
   The reasoning at the time is evidence. If we change our mind we supersede
   the ADR with a new one, and the history of why we changed stays visible.

3. **Why one writer per schema?**
   Ownership is clear, and one buggy service cannot corrupt another's tables.
   Readers get read-only roles.

4. **The assistant runs generated SQL. How do you make that safe?**
   Defense in depth: an allowlist in the tool, and a read-only database role,
   so a bad query is rejected by the database even if the app check fails.

5. **A secret was pushed to a public repo. What do you do?**
   Rotate it immediately. Removing it from history is not enough, because it
   may already have been copied. Then find out how it got there.

6. **What is the difference between gitleaks and Semgrep?**
   gitleaks finds leaked secrets in commits. Semgrep finds vulnerable code
   patterns in the source.

7. **Why must a `NEXT_PUBLIC_` variable never hold a secret?**
   It is bundled into client-side JavaScript, so anyone can read it.

8. **Your own CI flagged your CI. What happened?**
   Semgrep reported actions pinned to mutable tags and a Dependabot config
   with no cooldown. Both are supply-chain risks. I pinned the actions to
   commit SHAs and added a 7-day cooldown.

9. **Difference between a Docker image and a container?**
   The image is the read-only template; a container is a running instance of
   it. One image can start many containers.

10. **Who stops a service from writing to another service's schema: the
    application or the database?**
    The database. Each service connects with its own role, and Postgres checks
    every statement against that role's grants. It does not depend on the
    application code being correct.

11. **A role can `SELECT` from a table but gets `permission denied for
    schema`. Why?**
    Permissions are layered. It lacks `USAGE` on the schema, which is checked
    before the table's `SELECT`.

12. **What does PetrIA claim, and what does it not claim?**
   It estimates *expected* productivity from existing wells using public data.
   It does not find oil (seismic data is not public) and it is not investment
   or drilling advice.

## Day 2: Data research and re-plan

### Concepts

**Evidence tiers.** A research report is only as good as its sources. We tag
each claim by where it came from: the official source, a copy of the official
metadata, a project that uses the data, or a search summary. A claim nobody
read at the source stays `UNVERIFIED`. Research tells you what to check;
verification checks it.

**Design doc vs ADR.** The design doc (`docs/design.md`) is one page that
frames the whole project: problem, goals, alternatives, risks. An ADR records
one decision in depth. The design doc links to the ADRs.

**Amending an ADR.** Accepted ADRs are immutable, but a new ADR can *amend*
an old one. The old file only gets a pointer (`Amended by 0004`). The reasoning
of both stays visible.

**CKAN.** The open-source data portal software behind `datos.gob.ar`. Its API
exposes dataset metadata (`package_show`: resources, license, last modified)
and resource details (`resource_show`: the download URL). We use it to check
facts instead of trusting a web page.

**Open-data licenses.** CC-BY 4.0 allows reuse, including commercial, if you
give credit, link the license and say what you changed. When the license is
unclear, the safe default is a non-commercial demo with attribution. This is
not legal advice.

### Interview questions

1. **Your research report says the data has certain columns. Do you trust it?**
   No. It came from secondary sources. I read the real files first and only
   then write code. Every unverified claim is labeled.

2. **How do you handle an unclear data license in a portfolio project?**
   Cite the source, label derived data, don't re-host raw files, don't charge
   users, record the decision in an ADR, and verify the license from the
   portal's metadata.

3. **When would you write an ADR, and when a design doc?**
   An ADR for one hard-to-reverse decision and its alternatives. A design doc
   to frame the whole project before coding.

4. **You decided against a monorepo, then added a shared-modules repo. Isn't
   that inconsistent?**
   It's a documented exception (ADR-0004): the modules are reused across
   projects and built together, so one small shared repo is cheaper than six.
   The product repos stay separate.

5. **Why drop billing from the plan?**
   The data license is unconfirmed, and payments are not the skill the project
   shows. Usage metering and quotas reuse the cost traces and take about a
   third of the time (ADR-0006).

## Algorithms used in production

*(None yet. The first spot is the hash-map well index in `PetrIA-Ingest`.)*
