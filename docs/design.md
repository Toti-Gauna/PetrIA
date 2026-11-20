# Design: PetrIA

Status: draft for review · 2026-11-20 · one page

## Problem
Premise (not yet validated with real operators): daily reports are typed by
hand, wells are valued in Excel, and field engineers cannot query data
hands-free. Official data about Vaca Muerta is public, but it is spread over
large CSV files and shapefiles with unclear keys.

PetrIA joins that data into one map, estimates *expected* productivity for
undrilled areas, and answers questions with citations. It does not discover
oil (seismic data is not public) and it is not drilling or investment advice.

## Goals by version
| Version | Date | What a user can do |
|---|---|---|
| 1.0 MVP | Dec 1 | See wells and a P10/P50/P90 heat map; ask the assistant |
| 1.1 Product | Dec 12 | Value a well, forecast decline, upload a daily report, log in |
| 2.0 Platform | Dec 22 | Get alerts (WhatsApp, email, phone), talk to the assistant |
| 3.0 Production | Jan 5 | Same product, load-tested and operable, with AR and sensors |

Non-goals: finding oil, giving advice, using private operator data, charging
users (see ADR-0005).

## Decisions and alternatives
| Decision | Chosen | Rejected | Why |
|---|---|---|---|
| Code layout | Polyrepo, plus one shared kit | Monorepo | Independent deploys; contracts become real ([ADR-0001](adr/0001-polyrepo-and-service-boundaries.md), [0004](adr/0004-platform-kit-shared-modules.md)) |
| Data ownership | One writer per schema | Shared schema; one database per service | The database enforces who can write ([ADR-0002](adr/0002-one-writer-per-schema.md)) |
| Detector | LightGBM quantile regression, spatial CV, neighbor-average baseline | Point-estimate models; kriging (heavier, not tested here) | Decisions need an interval, not one number |
| Assistant | Tool-using agent (LangGraph) plus RAG | Plain RAG chat; free-form text-to-SQL | Numbers come from SQL under a read-only role; documents come from retrieval |
| Data trust | Verify against real files before ingesting | Ingest what research reports say | The research used secondary sources only |
| Money | Usage metering and quotas | Payments and billing | License unconfirmed ([ADR-0005](adr/0005-data-license-unconfirmed.md), [0006](adr/0006-usage-metering-instead-of-billing.md)) |

## Risks
| Risk | Mitigation |
|---|---|
| Data facts are unverified (columns, CRS, license, keys) | A verification notebook runs against the real portal before any loader is written |
| Leakage inflates the detector's score | Neighbor features use only wells whose 12 months were complete at the target's start; spatial block CV; a test that fails on leakage |
| The detector does not beat the baseline | Publish the real numbers and say so |
| Scope is larger than the time | Versions with dates; if one slips, move dates, not depth |
| Costs (model API, third-party services) | Spending caps in code; a mock LLM for load tests |
| Lead times (WhatsApp verification, email sending approval) | Owner started the paperwork early (durations unverified) |

## Open questions
- Does any license apply to the datasets? The official catalog says "No se
  especificó la licencia" for every dataset seen ([data sources](data-sources.md)).
  Whether portal-wide terms apply is not verified.
- Is `idpozo` one id per physical well or per well-and-formation? 85,858 ids
  against 78,592 well names says it is finer than a well; the reason is not
  proven ([data sources](data-sources.md)).
- How do wells link to concessions: an id, a name, or only geometry? No key is
  verified yet.
- Will the detector beat the neighbor average under spatial cross-validation?
