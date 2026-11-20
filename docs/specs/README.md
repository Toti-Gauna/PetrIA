# Specs (SDD)

One short spec per batch, written **before** any code. It is the written form of
"explain what it is and why we need it". About one page, about 15 minutes. For
tiny changes, one paragraph in the pull request is enough.

File name: `<batch>-<short-name>.md`, for example `1B-ingestion.md`.

## Template
```markdown
# Spec <batch>: <title>

Status: Draft | Approved by the owner (date)
Model tier and effort: ... · Planned hours: ...

## Problem and evidence
What problem, and how do we know? Mark each fact: verified or not confirmed.

## User and flow
Who uses it, and what do they do, step by step?

## What already exists (reuse)
Files, tables, tools, decisions (ADRs) we build on.

## Requirements
- ...

## Non-goals
- What we will not do in this batch.

## Data and permissions
Which schema it writes (one writer per schema), which it reads, which role.

## States and errors
Empty, loading, failure, partial data.

## Done when
Testable: a command, a query, a number.

## Risks and assumptions
- ...

## Stop condition
When to stop and ask the owner instead of pushing on.

## Teach-back
Two or three questions the owner should be able to answer afterward.
```

Rules: important decisions get two options with pros and cons, and the owner
chooses. The spec is updated in the same pull request if the plan changes.
