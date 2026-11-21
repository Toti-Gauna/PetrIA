# Build prompt 1C: Detector

**Run with:** Opus 5.5, effort high · **Planned:** 18 h · **Repo:** `PetrIA-ML`
**Before you paste this:** batch 1B is merged and `geo` has data in Neon. You have seen the 1C lesson (leakage, P10/P50/P90) in the Learning Pack.

---

You are the builder for batch 1C of PetrIA, the detector. Work in the `PetrIA-ML` repo on the branch the session names. Never push to main. You may use the `petria-data-ml` agent.

## Read first
1. `CLAUDE.md` of this repo, `docs/roadmap.md` (batch 1C), ADR-0002.
2. `docs/data-sources.md` and the `geo` schema in the `PetrIA-Ingest` repo (read only).
3. The honesty rule: PetrIA estimates expected productivity from existing wells. It does not find oil. Every number we show must come from a measured result.

## Goal
For each hexagon (H3 cell) of undrilled area in Vaca Muerta, predict the 12-month cumulative oil of a new well as three numbers: P10 (low case), P50 (middle), P90 (high case). Write them to schema `ml`. Measure how good they are, honestly.

## Step 1: the spec, then STOP
Write `docs/specs/1C-detector.md`. It must define, in plain words and testable terms:
- the target: cumulative oil in the first 12 producing months of a well;
- which wells are in the training set (a well needs 12 full months; say how you treat left-censored wells);
- the features and, for each, the exact date it is allowed to use (see leakage rule);
- the baseline: average of the K nearest neighbours;
- the metrics: P50 error (MAE and median absolute error) and the real coverage of the P10–P90 band (about 80% if calibrated);
- two options for how to split data for validation (random vs spatial blocks) with your recommendation (spatial blocks).
Stop and wait for the owner's OK.

## Step 2: build (after approval)
1. **Leakage test first.** Write a test that fails if any neighbour feature uses a well whose 12-month window was not complete before the target well's start date. Make it pass with a small, readable function. Show the owner a timeline example with three neighbours.
2. **Algorithm spots.** For each, say "Algorithm spot: <name> — mode: <mode>" and stop:
   - sliding window moving average (no-AI): the owner writes it, you give 3 tests and the expected complexity;
   - binary search over a time series to find "the first month at or after a date" (no-AI);
   - k-d tree for nearest neighbours (AI-assisted): you propose, the owner validates complexity, edge cases and changes out loud before you continue.
3. Baseline model: average of neighbours. Record its metrics first. The detector must beat it or we say it does not.
4. LightGBM quantile regression, three models with `alpha` 0.1, 0.5, 0.9. Fix the order of quantiles if they cross (explain why they can).
5. Spatial block cross-validation (blocks of H3 cells at a coarser resolution). Report P50 error and real P10–P90 coverage per fold and overall, next to the baseline.
6. Predict on the H3 grid (resolution chosen in the spec) over undrilled cells, with a flag for cells far from any training well ("extrapolation: low confidence").
7. Write results to `ml.cell_prediction` and a model registry table `ml.model_version` (version, date, data hash, metrics). Role `ml_rw` owns `ml`.
8. A short model card in `docs/model-card.md`: what it predicts, data, metrics, limits, "not drilling or investment advice".

## Rules
- Never invent data. If the numbers are bad, publish them as they are and say why.
- No secrets in the repo. Public repo: no personal data.
- Tests with pytest; keep CI green.
- Use plain words when you explain; every technical term gets one line of meaning and one PetrIA example.

## Done when
- The leakage test exists, fails when you break the rule on purpose, and passes now.
- A table compares baseline and LightGBM on P50 error and coverage, from spatial CV.
- `ml.cell_prediction` has rows, with P10 ≤ P50 ≤ P90 on every row (a test checks it).
- `docs/learning.md` updated with concepts, interview questions, and the three spots under "Algorithms used in production".

## Close the batch
Per `teach-back` and `handoff`: break-it experiments (for example, remove the leakage rule and predict what happens to the score), an explain-back, a pull request, no merge. Announce the next batch: 1D, Sonnet 5.5, effort medium, and say that `petria-backend` agent should be created first.
