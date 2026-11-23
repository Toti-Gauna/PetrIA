# Progress (plan v12.2)

The plan is [docs/plan/master-prompt.md](plan/master-prompt.md). One chat per
batch; each batch goes through Phase A (lesson), B (gate), C (build) and D
(close).

## Where we are
- **Current batch:** 0.0 Onboarding · Phase D (close). Gate passed (over 80% after retries, no debt). Left: the 2 minutes out loud, the times, the PR review.
- **Date:** 22 Nov 2026. Wave 0 was planned for 21 Nov, so we are about one
  day behind the estimate. The deadlines still hold (1.0 deadline: 1 Dec).

## Batches

Status: pending · lesson · gate · build · review · done · debt.

| # | Batch | Repos | h | Estimated | Deadline | Model · effort | Status | Study h | Build h | Review h | Claude week % |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0.0 | Onboarding | — | 1.5 | 21 Nov | 21 Nov | Opus · high | close | | | | |
| 0.1 | Repos, CI & Docker | all 5 | 3 | 21 Nov | 21 Nov | Sonnet · medium | pending | | | | |
| 0.2 | Database & roles | ingest | 2.5 | 21 Nov | 21 Nov | Opus · high | pending | | | | |
| 1.1 | Ingest & cleaning | ingest | 7 | 21–22 Nov | 22–23 Nov | Opus · xhigh | pending | | | | |
| 1.2 | Messaging & concessions | ingest, ml | 3 | 22 Nov | 23 Nov | Sonnet · high | pending | | | | |
| 1.3 | Features & baseline | ml | 6 | 22–23 Nov | 24 Nov | Opus · xhigh | pending | | | | |
| 1.4 | P10/P50/P90 detector | ml | 7 | 23 Nov | 25–26 Nov | Opus · xhigh | pending | | | | |
| 1.5 | Read API | api | 4 | 23–24 Nov | 27 Nov | Opus · high | pending | | | | |
| 1.6 | Map | web | 5 | 24 Nov | 28 Nov | Fable · xhigh | pending | | | | |
| 1.7 | Assistant with citations | assistant, api | 6 | 24–25 Nov | 29–30 Nov | Opus · xhigh | pending | | | | |
| 1.8 | Production 1.0 + release | all 5 | 2 | 25 Nov | 1 Dec | Sonnet · high | pending | | | | |
| 2.1 | Well value & decline | ml, api | 7 | 25–26 Nov | 2–3 Dec | Opus · high | pending | | | | |
| 2.2 | Daily-report reader | ingest | 7 | 26 Nov | 4–5 Dec | Opus · high | pending | | | | |
| 2.3 | Login & companies | api, web | 8 | 26–27 Nov | 6–7 Dec | Opus · xhigh | pending | | | | |
| 2.4 | Serious AI + feedback loop | assistant | 8.5 | 27–28 Nov | 8 Dec | Opus · high | pending | | | | |
| 2.5 | Quality | all 5 | 6 | 28–29 Nov | 9 Dec | Sonnet · high | pending | | | | |
| 2.6 | Observability, evals in CI & security | all 5 | 8 | 29 Nov | 10–11 Dec | Opus · high | pending | | | | |
| 2.7 | 1.1 screens + release | web | 4 | 29–30 Nov | 12 Dec | Fable · high | pending | | | | |
| 3.1 | notification-service | platform-kit | 8 | 30 Nov | 13–14 Dec | Opus · high | pending | | | | |
| 3.2 | Real channels | platform-kit, api | 9 | 1 Dec | 15–16 Dec | Opus · high | pending | | | | |
| 3.3 | voice-gateway | platform-kit | 10 | 1–2 Dec | 17–19 Dec | Opus · xhigh | pending | | | | |
| 3.4 | Usage & quotas | api, platform-kit | 6 | 2–3 Dec | 20 Dec | Sonnet · high | pending | | | | |
| 3.5 | Design system + 2.0 release | web | 7 | 3–4 Dec | 21–22 Dec | Fable · high | pending | | | | |
| 4.1 | load-lab | platform-kit | 14 | 4–5 Dec | 23–25 Dec | Opus · high | pending | | | | |
| 4.2 | Operations | all 5 | 12 | 5–6 Dec | 26–28 Dec | Opus · high | pending | | | | |
| 4.3 | Ingest on AWS | ingest | 10 | 6–7 Dec | 29–30 Dec | Opus · high | pending | | | | |
| 4.4 | Physical layer | web, ingest | 14 | 7–8 Dec | 31 Dec – 3 Jan | Fable · high | pending | | | | |
| 4.5 | Scale report + 3.0 release | all 5 | 8 | 9 Dec | 4–5 Jan | Sonnet · medium | pending | | | | |

Total planned: 193.5 h (wave 0: 7 h, 1.0: 40 h, 1.1: 48.5 h, 2.0: 40 h,
3.0: 58 h).

## Comprehension debt

Batches built with the emergency key. A batch with debt is not done until I
pass its questions.

| Batch | What I didn't pass | Logged | Paid |
|---|---|---|---|
| — | — | — | — |

## Decisions

| Date | Decision | Why |
|---|---|---|
| 22 Nov 2026 | Adopt plan v12.2 (three tracks, Imán at 3.0, design for extraction). It replaces `docs/roadmap.md` (batches 1A–4G). | A plan where understanding comes before building. |
| 22 Nov 2026 | The public copy of the master prompt summarizes section 2 (the owner's personal profile). **Confirmed by the owner (23 Nov): no personal data in the repo.** | This repo is public and feeds the portfolio. Rule: no personal data in public repos. |
| 22 Nov 2026 | Repo names: `petria-web` = `PetrIA`, `petria-ingest` = `PetrIA-Ingest`, `petria-ml` = `PetrIA-ML`, `petria-api` = `PetrIA-BE`, `petria-assistant` = `PetrIA-RAG`. **Decided (option A, 23 Nov): keep these five repos; no `-v0` rename.** | Recreating repos would cost time and gain nothing; the verified data facts and Wave 0 docs are already here. |
| 22 Nov 2026 | Wave 0 work from before v12.2 stays: verified data facts (`docs/data-sources.md`), ADRs 0001–0007, the agent team and the skills. Batch 0.1 reconciles the ADR numbering with section 6. | Verified facts are kept; nothing is re-measured. |
| 23 Nov 2026 | **Open, decided at table creation (0.2 / 1.1):** do not load the 40-column production file as one wide table. Split it into narrower tables linked by foreign keys (for example wells, production by month, formation). The 26-column vs 40-column precision note in the plan stays. | The owner's idea: 40 columns is too many for one table; fragmenting is cleaner. The final split will be a two-option decision with pros and cons. |

## Next batch

**0.1 Repos, CI & Docker** · Sonnet 5.5 · medium · 3 h planned.
- Dates: the estimate and deadline were 21 Nov and have passed. The 1.0 deadline
  (1 Dec) still holds: remaining work to 1.0 is about 45 h (0.1, 0.2, Wave 1).
- Depends on: 0.0.
- Starts with its lesson (Phase A). Most of it already exists (the five repos,
  CI with gitleaks and Semgrep, ADRs 0001-0007). What is new: Dockerfiles, one
  `docker-compose.yml` (Postgres + PostGIS + pgvector, RabbitMQ), and aligning
  the ADR numbers with the plan.
