# 0008. Only Vaca Muerta goes into the model; Quintuco is shown, not modeled

Status: Accepted (2026-11-23)

## Context
The production file mixes formations. By the `formacion` column (verified in
[data-sources](../data-sources.md)): "vaca muerta" has 226,814 rows, "lajas"
78,981, "mulichinco" 35,526, "los molles" 28,658 and "quintuco" 11,196. Quintuco
is the layer above Vaca Muerta. `SHALE` is not the same as Vaca Muerta (234,722
vs 226,814 rows), so the resource type cannot stand in for the formation.

## Options
A. **Model every unconventional well together.** More data, but different rocks
   produce differently, so the neighbours would mislead the estimate.
B. **Model only Vaca Muerta** (`formacion` = `vaca muerta`) and show Quintuco on
   the map (chosen).
C. **Treat Quintuco as part of Vaca Muerta.** Not supported by the data.

## Decision
Option B. The detector trains and predicts only from wells whose `formacion` is
`vaca muerta`. Quintuco wells can be shown on the map but never feed the model.
How they are drawn is decided in the map batch (1.6).

## Consequences
+ A model that compares like with like.
+ Quintuco can be added later with its own model, without redoing this one.
- Fewer training wells than "all unconventional".
- Depends on the `formacion` text being clean: spelling variants (12 less common
  values are not yet reviewed) can drop wells by mistake. Batch 1.1 checks this.
