# Architecture Decision Records (ADRs)

An ADR is a short file that records **one** important technical decision: the
context, the options considered, what we chose, and the consequences.

## Rules

1. One decision per file, about one page.
2. ADRs are **immutable** once accepted. To change a decision, write a new ADR
   and mark the old one `Superseded by NNNN`. The history of the change is
   part of the value.
3. Write one when a decision is hard to reverse, or when someone could
   reasonably ask "why not the other way?".

## Index

| # | Title | Status |
|---|---|---|
| [0001](0001-polyrepo-and-service-boundaries.md) | Polyrepo and service boundaries | Accepted |
| [0002](0002-one-writer-per-schema.md) | One writer per database schema | Proposed |
| [0003](0003-public-repos-and-secrets-policy.md) | Public repositories and secrets policy | Accepted |

## Template

```markdown
# NNNN. Title

Status: Proposed | Accepted | Superseded by NNNN (YYYY-MM-DD)

## Context
What forces us to decide?

## Options
A. ...
B. ...

## Decision
What we chose, and why.

## Consequences
+ What gets better.
- What gets worse or harder.
```
