# Roadmap: waves from 0 to 3.0

North star: one complete project that I can explain end to end, shipped in
dated versions. If a version slips, the dates move, not the depth.

## How to read this
- **Wave** = one version (1.0, 1.1, 2.0, 3.0), plus Wave 0 for foundations.
- **Batch** = a group of tasks built together and reviewed in one pull request.
- **Hours** = planned estimates, not measurements. We calibrate them with a
  private hours log.
- **Dates** = windows, not promises. Each window has slack (see the table).
- **Model and effort** = a suggestion for the AI that builds the batch, not a
  measured result.
  - *Strong* (Opus 5.5): design, safety-critical or subtle logic.
  - *Standard* (Sonnet 5.5): most build work.
  - *Light* (Haiku 5.5): mechanical, repetitive work.
  - Fable 5.2 also exists, but there is no basis here to place it.
  - *Effort* (low, medium, high) is how much the AI should think per task.
    Higher effort is slower and uses more of the plan's limits.
- Every batch ends with: a pull request with a written review, an explain-back,
  "break it" experiments, and updated docs.

## The five waves at a glance
| Wave | Version | Window | Planned h | Slack | Demo (30 seconds) |
|---|---|---|---|---|---|
| 0 | Foundations | Nov 19–20 | n/a | n/a | Repos, CI, decisions, design |
| 1 | **1.0 MVP** | Nov 20 – Dec 1 | 74 | ~22 h | Click a map cell, see P10/P50/P90, ask a cited question |
| 2 | **1.1 Product** | Dec 2–12 | 74 | ~14 h | Value a well, forecast its decline, upload a report photo, log in |
| 3 | **2.0 Platform** | Dec 13–22 | 64 | ~16 h | WhatsApp alert with buttons, call fallback, voice moves the map |
| 4 | **3.0 Production** | Dec 23 – Jan 5 | 81 | ~31 h (less on holidays) | Scale report with a breaking point and its fix; AR well |

Slack = window at about 8 h/day minus planned hours.

## Wave 0 · Foundations (done)
| Batch | What it is | Model · effort |
|---|---|---|
| 0A | Five repositories, CI with secret scan and static analysis | Standard · medium |
| 0B | Decisions (ADRs 0001–0006), architecture, design doc | Standard · medium |
| 0C | Data research and re-plan into versions | Standard · medium |
| 0D | Verification notebook for the data sources | Standard · medium |

## Wave 1 · 1.0 MVP (Nov 20 – Dec 1)
Public map + detector + assistant, deployed.

| Batch | What it is | Model · effort | Hours | Window |
|---|---|---|---|---|
| 1A | Verify the data: run the notebook, record the real facts | Standard · medium | 6 | Nov 20–21 |
| 1B | Ingestion: Neon, schemas and roles, loaders for wells, production, fracturing, cleaning, monthly job. *Spot: hash-map well index (no-AI)* | Standard · medium | 13 | Nov 21–22 |
| 1C | Detector: leakage-safe features, LightGBM quantile (P10/P50/P90), spatial CV, H3 grid, registry. *Spots: sliding window, binary search (no-AI); k-d tree (AI-assisted)* | **Strong · high** | 18 | Nov 23–25 |
| 1D | Read-only API: Spring Boot, endpoints, OpenAPI | Standard · medium | 6 | Nov 26 |
| 1E | Map: wells, heat map, concessions, cell detail | Standard · medium | 12.5 | Nov 27–28 |
| 1F | Assistant: read-only SQL tool, detector lookup, RAG, citations, abstention, 20 evals | **Strong · high** | 12.5 | Nov 29–30 |
| 1G | Ship: deploy, README, demo, release notes 1.0 | Standard · low | 6 | Dec 1 |

Why strong·high: the detector can look great and be wrong (data leakage), and
the assistant runs generated SQL, so safety matters.
If we slip: fewer evals first, then drop the concessions layer.

## Wave 2 · 1.1 Product (Dec 2–12)
The tools people use, plus the quality and safety around them.

| Batch | What it is | Model · effort | Hours | Window |
|---|---|---|---|---|
| 2A | Flagship tools: well value calculator (NPV, payback, breakeven), decline forecast (Arps) | Standard · medium | 12 | Dec 2–3 |
| 2B | Assistant hardening: 40–60 evals, structured outputs, retries, cost traces and cap, model router, semantic cache. *Spot: LRU cache (AI-assisted)* | **Strong · high** | 12.5 | Dec 4–5 |
| 2C | Identity: Keycloak, OIDC, tenants, saved zones, history. *Spot: undo/redo stack (AI-assisted)* | **Strong · high** | 12.5 | Dec 6–7 |
| 2D | Daily report reader (PDF, Excel or photo to validated data) | Standard · medium | 6 | Dec 8 |
| 2E | Quality gates: Pact, Playwright, accessibility, Lighthouse, ES/EN | Standard · medium | 12 | Dec 9–10 |
| 2F | Observability and safety: OpenTelemetry, one k6 scenario with a mock LLM, MCP server, threat model. *Spot: token bucket (AI-assisted)* | Strong · medium | 12.5 | Dec 10–11 |
| 2G | Release 1.1: README, notes, demo, mock interview | Standard · low | 6.5 | Dec 12 |

Why strong·high: tenant isolation and LLM safety are the parts that break
quietly.
If we slip: the report reader and the k6 scenario move to 2.0.

## Wave 3 · 2.0 Platform (Dec 13–22)
Reach people outside the web app. Reusable parts go into `platform-kit`.

| Batch | What it is | Model · effort | Hours | Window |
|---|---|---|---|---|
| 3A | `platform-kit` repo and notification-service core: channel router, idempotency, dedup, caps, send log | Standard · high | 12 | Dec 13–14 |
| 3B | WhatsApp (Meta Cloud API): templates, buttons, webhooks | Standard · medium | 10 | Dec 15–16 |
| 3C | Email (Amazon SES): DNS records, bounces, unsubscribe, weekly PDF | Standard · medium | 8 | Dec 17 |
| 3D | Phone (ElevenLabs agent + Twilio) | Standard · medium | 10 | Dec 18–19 |
| 3E | Voice assistant: speech in, tools, speech out, barge-in, confirmations | **Strong · high** | 14 | Dec 19–21 |
| 3F | Usage metering and quotas per tenant | Standard · medium | 3 | Dec 21 |
| 3G | Design system with Storybook | Standard · low | 7 | Dec 22 |

Risks: approval lead times (WhatsApp, SES) are unverified; each third-party
API needs a key and, in this setup, network approval; spending is capped at
USD 50 per month.

## Wave 4 · 3.0 Production (Dec 23 – Jan 5)
Prove it holds up, and show the extras.

| Batch | What it is | Model · effort | Hours | Window |
|---|---|---|---|---|
| 4A | load-lab: k6 users and spikes, mock LLM, S/M/L data, chaos, Grafana | Standard · high | 24 | Dec 23–26 |
| 4B | Operations: SLOs and alerts, feature flags, safe migrations, backup drill, graceful degradation, runbooks | **Strong · high** | 22 | Dec 27–30 |
| 4C | Scale report: users, p95, breaking point, fix, cost per user | Standard · medium | 6 | Dec 31 – Jan 1 |
| 4D | AWS ingestion: S3, SQS, Lambda | Standard · medium | 10 | Jan 2 |
| 4E | AR well with AR Quick Look (USDZ, opened from the web) | Standard · medium | 5 | Jan 3 |
| 4F | Simulated sensors on Wokwi with MQTT and a live dashboard | Standard · medium | 6 | Jan 3–4 |
| 4G | GPS "wells near me" and phone scanner | Standard · low | 8 | Jan 4–5 |

Notes: the 100M-row test waits for the new PC, and whether Neon can hold it is
unverified. Simulated parts are always labeled.

## Where we are now
Wave 1, batch 1A: the verification notebook is merged, and the next step is to
run it in Colab and read the real facts.

## Totals
Planned: 74 + 74 + 64 + 81 = 293 h across Waves 1 to 4, plus Wave 0.
