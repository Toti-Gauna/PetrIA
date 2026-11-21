---
name: learning-pack
description: "Before a batch, teach the concepts with pictures, worked examples and a plain-language glossary, then hand over the build prompt. Use at the start of every batch, before the spec."
---

# Skill: Learning pack

## Purpose
The owner learns by seeing examples first. Jargon without a picture does not
stick. The pack replaces "explain a lot in chat" with something visual that can
be reopened, and it gates the build prompt behind a short check.

## Steps
1. List the new words of the batch. For each: plain meaning, a comparison with
   JavaScript, Express, SQL Server or Spring, and a PetrIA example. Add them to
   the glossary of the pack.
2. For each hard idea, draw one figure that shows the mechanism (data flow,
   before and after, timeline, a scatter). Use made-up numbers only when
   labeled as made-up; real numbers come from `docs/data-sources.md`.
3. Add a "Predict first" question to each example, with the answer hidden.
4. Write three check questions for the batch (two right unlock the prompt).
5. Save the build prompt in `docs/prompts/<batch>-<name>.md`: model and effort
   at the top, files to read first, a spec step that stops for the owner,
   small tested steps, stops for algorithm spots, rules, done-when, and the
   next batch announcement.
6. Publish the pack and tell the owner which model and effort to use.

## Rules
- One prompt per batch, not per wave.
- No secrets, no personal data, no invented facts. Mark anything unverified.
- Check the rendered page at tablet and phone width before sharing.
