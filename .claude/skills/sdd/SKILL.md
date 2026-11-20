---
name: sdd
description: "Spec-Driven Development for PetrIA: write a one-page spec before any code for a batch or a module. Use at the start of every batch longer than about an hour, and whenever a new module, endpoint, table or screen is requested."
---

# Skill: SDD (spec before code)

## Purpose
A short spec makes the owner and the agent agree on *what* and *why* before any
code exists. It is the written form of the first teaching rule: explain what
it is and why we need it.

## When to use
- Start of every batch (1B, 1C, ...) and every new module.
- Not needed for typo fixes, renames or one-line changes: put one paragraph in
  the pull request instead.

## Process
1. Discover first (skill `discovery`): what exists, what can be reused.
2. Write the spec in `docs/specs/<batch>-<short-name>.md`, using the template
   in `docs/specs/README.md`. One page, about 15 minutes.
3. If the spec contains an important decision, give two options with pros and
   cons and wait for the owner's choice.
4. Wait for the owner's OK on the spec. Only then write code.
5. If the plan changes, change the spec in the same pull request.

## Rules
- *Done when* must be testable: a command, a query, a number.
- *Non-goals* are mandatory: say what we will not do.
- State the **stop condition**: when to stop and ask instead of pushing on.
- Estimate hours and the model tier (see `docs/roadmap.md`).
- Mark each fact as verified or not confirmed (skill `evidence`).
