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

8. **What does PetrIA claim, and what does it not claim?**
   It estimates *expected* productivity from existing wells using public data.
   It does not find oil (seismic data is not public) and it is not investment
   or drilling advice.
