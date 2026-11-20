# Day 2: Data research and re-plan

Date: 2026-11-20 · Version 1.0 (MVP)

## Goal
Find out which official datasets PetrIA can use, and re-plan the project
after the scope grew.

## What happened

### 1. Data research (five parallel angles)
One angle per dataset (production per well, well registry and shapefile,
fracturing, concessions) plus one on license, access and joins.

**The main result is a limit.** The researchers could not open any official
page: the portal hosts (`datos.gob.ar`, `datos.energia.gob.ar`) were blocked
in the research environment. Every finding comes from a stale copy of the
portal metadata, public projects that use the data, or search summaries.
The report labels each claim with its evidence level and keeps `UNVERIFIED`
wherever nothing was read at the source. We treat it as a map of what to
check, not as proof.

What the research suggests (all unverified):
- `idpozo` identifies a well *in a formation*, not a physical well. `sigla`
  looks like the physical well. This changes how we join.
- The fracturing data has one row per operation, with many placeholder zeros.
- Concessions are polygon layers with no known well key, so linking wells to
  concessions is probably a spatial join.
- The data dictionary labels `coordenadax` as latitude and `coordenaday` as
  longitude, the reverse of the usual convention.
- The license is unclear: three conflicting statements, none official.

### 2. Re-plan into versions
The scope grew (flagship tools, notifications, voice, scale and operations,
AR and sensors), roughly twice the available time. We now ship in dated
versions: 1.0 on Dec 1, 1.1 on Dec 12, 2.0 on Dec 22, 3.0 on Jan 5. If a
version slips, the dates move, not the depth.

### 3. New working rules
- Algorithm spots: the owner writes some classic algorithms by hand (no AI),
  and validates others out loud (AI-assisted).
- One pull request per module or day, with a written review before merging.
- Real hours are logged privately, for plan calibration.

## Decisions
- [ADR-0004](../../docs/adr/0004-platform-kit-shared-modules.md): a shared
  `platform-kit` repository for reusable modules (an exception to ADR-0001).
- [ADR-0005](../../docs/adr/0005-data-license-unconfirmed.md): the data
  license is unconfirmed, so PetrIA is a non-commercial demo.
- [ADR-0006](../../docs/adr/0006-usage-metering-instead-of-billing.md):
  usage metering and quotas instead of billing.

## What we built
- The project rules (`CLAUDE.md`) updated in all five repositories.
- The one-page [design](../../docs/design.md).
- The [roadmap by waves](../../docs/roadmap.md): every version split into batches,
  with hours, window, and a suggested model and effort.
- ADRs 0004 to 0006, and the README roadmap by version.
- A verification notebook in `PetrIA-Ingest` that checks the research claims
  against the real files (it has not run against the real portal yet).

## Not done (and why)
- **No dataset fact is verified.** The notebook has to run where the portal is
  reachable (Google Colab) first.
- **No code for the pipeline.** Writing loaders before knowing the real
  columns, coordinate system and keys would be guessing.

## Next
Run the verification notebook in Colab (it is merged and ready), record what is
real, then Day 3:
database schemas and roles, and the wells and production loaders.

## New concepts
Evidence tiers for research, a design document versus an ADR, amending an ADR,
CKAN, open-data licenses (CC-BY), and why a research report is not
verification. See the [learning notes](../../docs/learning.md).
