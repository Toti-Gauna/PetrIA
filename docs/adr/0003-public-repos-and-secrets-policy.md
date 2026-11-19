# 0003. Public repositories and secrets policy

Status: Accepted (2026-11-19)

## Context
The project is meant to be read by recruiters and engineers, so the code and
the docs should be visible. Public repositories keep their full history
forever, so a mistake in one commit is a mistake permanently.

## Options
A. **Private repos, public docs.** Hides the code, which is the main proof of
   skill. Docs would need a token to be read from a private repo.
B. **Private during development, public at the end.** Needs a full-history
   secret scan before the switch, and docs would link to code that is not yet
   visible.
C. **Public from the first commit** (chosen), with strict rules from day one.

## Decision
All five repositories are public from the start. Rules:

1. No secrets, personal data or employer details in code, docs or history.
2. Configuration comes from environment variables. Each repo has a
   `.env.example` that lists names only, with no values.
3. Where secrets live:
   - **GitHub Actions secrets**: only what CI needs while it runs.
   - **Render environment variables**: what a running service needs, such as
     `DATABASE_URL` or `ANTHROPIC_API_KEY`.
4. Every repo runs a secret scan (gitleaks) and static analysis (Semgrep) on
   each push, and Dependabot keeps GitHub Actions up to date.
5. If a secret is ever committed, **rotate it first**. Rewriting history is
   not enough: the value may already have been copied.
6. Variables prefixed `NEXT_PUBLIC_` are sent to the browser, so they never
   hold secrets.

## Consequences
+ The work is verifiable by anyone, and the portfolio can read docs straight
  from the repo with no token.
+ Free, unlimited CI minutes on public repositories.
- Zero tolerance for mistakes: one leaked key means rotating it.
- Scanning in CI catches a leak only *after* the push. It is a safety net, not
  a substitute for care.
