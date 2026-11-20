# 0004. platform-kit: one shared repository for reusable modules

Status: Accepted (2026-11-20) · Amends [0001](0001-polyrepo-and-service-boundaries.md)

## Context
ADR-0001 chose one repository per deployable unit. Since then the scope has
grown to include modules meant to be reused by later projects, not only by
PetrIA: an ROI calculator, notification-service, voice-gateway, a design
system, usage metering and a load-testing lab. They are built together and
share tooling (TypeScript, NestJS, tests, CI).

## Options
A. **One repository per module.** Six or more extra repositories and CI
   setups; shared conventions are hard to change.
B. **One shared repository, `platform-kit`, with one package per module**
   (chosen).
C. **Copy the code into each project.** Fastest today, drifts tomorrow.

## Decision
Option B. Rules:
- Each package has its own README, tests and version.
- No PetrIA-specific code in the kit. PetrIA adapters live in PetrIA's repos.
- Services in the kit keep their own Dockerfile and deploy independently.
- ADR-0001 still applies to PetrIA's product repositories.

## Consequences
+ Reuse across projects, one CI, consistent conventions.
- The kit is a small internal monorepo: an exception to ADR-0001, and the
  trade-offs we avoided for the product repos come back here at small scale.
- How packages are versioned and distributed (GitHub Packages, npm, or git
  tags) is undecided. We decide when the first package is consumed (2.0).
- Risk of PetrIA details leaking into the kit. Pull request reviews check it.
