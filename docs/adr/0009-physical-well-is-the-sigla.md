# 0009. The physical well is the `sigla`, with its `idpozo` records

Status: Accepted (2026-11-23)

## Context
The well registry has 85,858 rows, one per `idpozo`, but only 78,592 distinct
`sigla` (verified). So several `idpozo` records share one `sigla`. **The cause of
the difference is not verified.** One reading is that a physical well can have
several records; that is consistent with the numbers but not proven.

If records of the same well were counted as different wells, the model could be
trained on one and tested on another that is almost identical, and its metrics
would look better than reality.

## Options
A. **One well per `idpozo`.** Simple, but risks counting a well more than once
   and leaking it across the train and test split.
B. **One well per `sigla`, keeping every `idpozo` as a record of it** (chosen).

## Decision
Option B. The unit of the model, of the train/test split and of the map is the
physical well, identified by `sigla`. Every `idpozo` is kept and linked to its
`sigla`, so nothing is lost. The open question (why the counts differ) is
documented, not guessed.

## Consequences
+ No physical well appears on both sides of the split; a test enforces it (1.4).
+ The cause of the difference can be investigated later without redoing the load.
- Rules are needed to merge a well's records (which location, which dates).
  They are decided in batch 1.1 and tested there.
