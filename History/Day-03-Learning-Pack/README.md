# Day 3: Learning pack and build prompts

Date: 2026-11-21 · Version 1.0 (MVP)

## Goal
Make learning faster and clearer: pictures and examples first, plain words for
every term, and one ready build prompt per batch of Wave 1.

## What happened
- The owner said the explanations lacked examples and diagrams, and used too
  much jargon. We changed the process (teaching rules 11 and 12 in `CLAUDE.md`).
- Built the **Wave 1 Learning Pack**, an interactive page with: a pipeline
  diagram, a who-writes-where table, five worked examples (file path to the
  cloud, two ids for one well, swapped coordinates, data leakage, P10/P50/P90),
  a glossary of about 80 words, and three check questions per batch.
- Wrote one build prompt per batch, 1B to 1G, in [docs/prompts](../../docs/prompts/README.md).
  Each one tells the builder to write a spec and stop for the owner's answer.
- Why one prompt per batch and not one for the whole wave: each batch needs the
  real output of the one before, and the owner must approve decisions in between.

## Evidence
- A probe workflow on GitHub's servers found that all six file links timed out,
  while the catalog answered. Recorded in [data sources](../../docs/data-sources.md).

## Not done
- Verification run 3 (needs the owner to run the notebook in Colab).
- Batch 1B has not started; it begins with a written spec.

## Next
Run 3, then batch 1B (Sonnet 5.5, effort medium).
