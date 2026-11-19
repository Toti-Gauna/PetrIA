# PetrIA

A map of the **Vaca Muerta** wells (Argentina) with a heat map of *expected*
productivity in undrilled areas, plus an AI assistant that answers questions
by citing official data.

> **What PetrIA is not.** It does not discover oil: seismic data is not
> public. It estimates expected productivity from existing wells, using public
> data. It is not drilling or investment advice.

## Status

**Stage 0: foundations.** The design, the decisions and the repo structure
exist. No feature is implemented yet. Metrics for the detector and the
assistant will be published here only after they are measured.

## How it is built

PetrIA is five repositories, each deployable on its own:

| Repo | Role | Stack |
|---|---|---|
| [PetrIA](https://github.com/Toti-Gauna/PetrIA) (this one) | Web, docs, build log | Next.js, TypeScript, MapLibre GL |
| [PetrIA-BE](https://github.com/Toti-Gauna/PetrIA-BE) | Platform API: users, organizations, saved zones | Java 21, Spring Boot, Keycloak (OIDC), Flyway |
| [PetrIA-RAG](https://github.com/Toti-Gauna/PetrIA-RAG) | AI assistant that cites its sources | Python, FastAPI, LangGraph, Claude, pgvector |
| [PetrIA-Ingest](https://github.com/Toti-Gauna/PetrIA-Ingest) | Data pipeline into PostGIS | Python, PostGIS, RabbitMQ |
| [PetrIA-ML](https://github.com/Toti-Gauna/PetrIA-ML) | The detector (productivity model) | Python, LightGBM, H3 |

Read the [architecture](docs/architecture.md) and the
[decision records](docs/adr/README.md) to see how the pieces fit and why.

## Roadmap (122 h, Nov 19 to Dec 5, 2026)

| Stage | What | Repo |
|---|---|---|
| 0 | Foundations: repos, CI, ADRs, docs | all |
| 1 | Data: clean wells, production and fracturing in PostGIS | Ingest |
| 2 | Detector: P10/P50/P90 predictions on a hex grid | ML |
| 3 | Backend core: read-only geo endpoints | BE |
| 4 | Map: wells, heat map, concessions | PetrIA |
| 5 | Auth and tenants: Keycloak, organizations, saved zones | BE + PetrIA |
| 6 | Assistant: RAG, citations, abstention, evals, cost cap | RAG |
| 7 | Quality: contract tests, end-to-end tests, CI hardening | all |
| 8 | Deploy and wrap-up | all |

## Repository layout

```
docs/          architecture, decision records (ADRs), learning notes
History/       one folder per working day: what we did and why
infra/         local docker-compose and Keycloak realm (added later)
```

The [build log](History/README.md) is written as the project advances, one
entry per working day.

## License

MIT. See [LICENSE](LICENSE).
