# 0001. Polyrepo and service boundaries

Status: Accepted (2026-11-19) · Amended by [0004](0004-platform-kit-shared-modules.md)

## Context
PetrIA has five independently deployable parts: a web app, a Java API, an AI
assistant, a data pipeline and an ML detector. They use three languages
(TypeScript, Java, Python) and are deployed separately (Render and a web host).
We must decide how to organize the source code.

## Options
A. **Monorepo.** One repository, one CI, atomic changes across services.
   Less overhead for one developer, but weaker isolation, and every service
   needs its own build and deploy configuration inside the shared repo.
B. **Polyrepo.** One repository per deployable unit.
   Independent deploys and clear ownership, at the cost of duplicated CI and
   coordination for changes that cross repositories.

## Decision
**Polyrepo**: five repositories.

| Repo | Responsibility |
|---|---|
| PetrIA | Web app, plus docs, build log and local infrastructure |
| PetrIA-BE | Platform API |
| PetrIA-RAG | AI assistant |
| PetrIA-Ingest | Data pipeline |
| PetrIA-ML | Detector |

Cross-service contracts are not stored in a shared repository. Each producer
generates its OpenAPI spec from code, and Pact files are exchanged through a
broker.

Both options are legitimate (large companies use each). Polyrepo was chosen
because it matches how the services deploy, and because it makes contract
testing a real need instead of an exercise.

## Consequences
+ Each service builds, tests and deploys alone.
+ Clear boundaries; the data schemas below the services are explicit
  ([ADR-0002](0002-one-writer-per-schema.md)).
- The same CI setup is repeated in five repos (mitigated by one shared
  workflow template).
- A change that spans services needs coordinated pushes.
- Estimated setup overhead: 5 to 8 hours of the 122-hour budget. This is an
  estimate, not a measurement.
