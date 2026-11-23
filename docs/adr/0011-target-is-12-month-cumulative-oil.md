# 0011. The target is 12-month cumulative oil, as P10 / P50 / P90

Status: Accepted (2026-11-23)

## Context
To compare wells of different ages fairly we need one number per well that
covers the same period. The usual choice is the oil produced in the first 12
months. A single predicted number hides how uncertain the estimate is, and
neighbouring wells can differ a lot.

## Options
A. **Cumulative oil in the first 12 months, one number.** Simple, hides risk.
B. **Cumulative oil in the first 12 months as three quantiles: P10, P50, P90**
   (chosen).
C. **A full decline curve from the start.** Richer, but it is the 1.1 forecast
   feature, not the base of the detector.

## Decision
Option B, with quantile regression (LightGBM). **Convention in PetrIA: P10 is the
pessimistic value (10th percentile) and P90 the optimistic one (90th).** Some
industry usage is the reverse, so the UI and the README state which one PetrIA
uses. Version 1.0 predicts barrels only. Gas, price, payback and decline curves
come in 1.1.

## Consequences
+ The range shows uncertainty; it is wider when neighbours disagree or are far.
+ We can measure how often real wells fall inside the P10-P90 interval.
- Three models (or outputs) instead of one, and a metric for coverage as well as
  for error.
- Wells younger than 12 months have no target and cannot be used for training.
