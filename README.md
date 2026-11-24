# PetrIA

A map of the **Vaca Muerta** wells (Argentina) with a heat map of *expected*
productivity in undrilled areas, plus an AI assistant that answers questions
by citing official data.

> **What PetrIA is not.** It does not discover oil: seismic data is not
> public. It estimates expected productivity from existing wells, using public
> data. It is not drilling or investment advice.

## Status

**Version 1.0 (MVP) in progress, due Dec 1.** The foundations, the
[design](docs/design.md) and the decisions exist, and the data research is
done. The dataset facts are not yet verified against the real files, so no
feature is implemented. Metrics for the detector and the assistant will be
published here only after they are measured.

## How it is built

PetrIA is five repositories, each deployable on its own:

| Repo | Role | Stack |
|---|---|---|
| [PetrIA](https://github.com/Toti-Gauna/PetrIA) (this one) | Web, docs, build log | Next.js, TypeScript, MapLibre GL |
| [PetrIA-BE](https://github.com/Toti-Gauna/PetrIA-BE) | Platform API: users, organizations, saved zones | Java 21, Spring Boot, Keycloak (OIDC), Flyway |
| [PetrIA-RAG](https://github.com/Toti-Gauna/PetrIA-RAG) | AI assistant that cites its sources | Python, FastAPI, LangGraph, Claude, pgvector |
| [PetrIA-Ingest](https://github.com/Toti-Gauna/PetrIA-Ingest) | Data pipeline into PostGIS | Python, PostGIS, RabbitMQ |
| [PetrIA-ML](https://github.com/Toti-Gauna/PetrIA-ML) | The detector (productivity model) | Python, LightGBM, H3 |

A sixth repository, `platform-kit`, will hold the reusable modules of version
2.0 ([ADR-0004](docs/adr/0004-platform-kit-shared-modules.md)).

Read the [design](docs/design.md), the [architecture](docs/architecture.md)
and the [decision records](docs/adr/README.md) to see how the pieces fit and
why.

## Roadmap

Each version ships with release notes, a demo video and an updated README. If
a version slips, the dates move, not the depth.

The batch-by-batch plan, with model and effort per batch, is in the
[roadmap](docs/roadmap.md).

| Version | Date | Contents |
|---|---|---|
| 1.0 MVP | Dec 1 | Data pipeline, detector (P10/P50/P90 on a hex grid), read-only API, map, assistant with citations, deploy |
| 1.1 Product | Dec 12 | Well value calculator, decline forecast, daily report reader, full evals and cost cap, login and tenants, contract and end-to-end tests, accessibility, ES/EN, tracing, MCP server, threat model |
| 2.0 Platform | Dec 22 | Notifications (WhatsApp, email, phone), voice assistant, usage metering and quotas, design system |
| 3.0 Production | Jan 5 | Load testing and chaos, operations runbooks, Scale report, AWS ingestion, AR well, simulated sensors, GPS |

## Repository layout

```
docs/          architecture, decision records (ADRs), learning notes
History/       one folder per working day: what we did and why
infra/         local docker-compose and Keycloak realm (added later)
```

The [build log](History/README.md) is written as the project advances, one
entry per working day.

## Local infrastructure

Needs Docker on your computer.

```bash
cd infra
cp .env.example .env              # local-only values, git-ignored
docker compose up -d --build --wait
docker compose exec db sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT postgis_version();"'
docker compose down               # data stays; "down -v" erases it
```

It starts Postgres with PostGIS and pgvector, and RabbitMQ (management UI on
`http://localhost:15672`). Production uses Neon instead of this container.

## License

MIT. See [LICENSE](LICENSE).
