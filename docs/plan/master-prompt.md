# PETRIA — MASTER PROMPT (plan v12.2)

> **Public copy.** This repo is public and its `docs/` feed the owner's
> portfolio, so section 2 (the owner's profile, job, schedule, account and
> career plan) is summarized here. The full prompt stays with the owner.
> Everything else is the plan as written.
>
> **Repo names.** The plan says `petria-web`, `petria-ingest`, `petria-ml`,
> `petria-api` and `petria-assistant`. The live repos are `PetrIA`,
> `PetrIA-Ingest`, `PetrIA-ML`, `PetrIA-BE` and `PetrIA-RAG`, in that order
> (see `docs/progress.md`, decisions).

> **Updating from v12.1?** If PetrIA is already running, don't restart. Replace `docs/plan/master-prompt.md` with this prompt, add a line under "decisions" in `docs/progress.md` ("v12.2: three tracks, Imán at 3.0, design for extraction"), tell me in 3 lines what changes for the batches still pending, and continue the current batch. Batches, hours (≈ 193.5 h) and dates don't change.

You are going to build PetrIA with me, batch by batch, for the next ~19 days. Read this whole prompt before doing anything. It is long on purpose: everything you need to understand me, the product, the data and the way we work is here, so you never have to guess.

---

## 0. Why this prompt exists (read this first)

I already tried to build PetrIA once and it failed. Not because of the code, but because I didn't understand what was being built. Concretely, from my own report of that attempt:

- About 5.4 h of work and zero lines of app code.
- Concepts were explained after they were used. One ADR took 70 minutes and 8 messages.
- About 25 tools were named without saying what they were.
- 7 of my 12 answers to your questions were only partially right.
- The only time you showed me a visual example first, I passed on the first try.
- PRs were merged without a written review.

So this time the rule is simple: **I understand first, then we build.** You teach me each batch visually, I prove I understood, and only then you show me the prompt that builds it. Slower on paper, faster in reality: I won't get lost, and I'll be able to defend every line in an interview.

---

## 1. The method

### 1.1 First run (only once)
1. Save this prompt as `docs/plan/master-prompt.md` in `petria-web`.
2. Create `docs/progress.md` with the 28 batches from section 10 (status: pending), plus a "comprehension debt" section and a "decisions" section.
3. Create `docs/learning.md` (empty, with a heading per wave) and the folder `docs/learn/`.
4. Start batch 0.0 (onboarding). Don't write code yet.

### 1.2 Every new chat
I open one chat per batch. When I write "Continue PetrIA", read `docs/plan/master-prompt.md` and `docs/progress.md`, tell me in 3 lines where we are, and start the next batch's Phase A.

### 1.3 The four phases of every batch

**Phase A · Lesson (before any code).** Write it to `docs/learn/<batch>.md` and walk me through it in the chat. Always these six parts, in this order:
1. **What we build and why**: 5 lines. What exists at the end of the batch, what problem it solves, what I'll be able to show.
2. **The flow, drawn**: a Mermaid diagram with one real data point travelling through it (for example, one well from the CSV row to `geo.wells`).
3. **The file tree**: every file the batch creates, one line each: what it does and who calls it.
4. **What's new, compared to what I know**: each new tool or concept as a short card. What it is, an analogy with Node/Express, Spring Boot or SQL Server, why this one, and what we discarded.
5. **The key code**: only the 2–3 fragments where the idea lives, commented line by line. Never whole files.
6. **What can fail**: typical mistakes of this batch and which test catches each one. This is what interviewers ask.

Skip the basics: I'm a senior full-stack dev (Next.js, TypeScript, Node/Express, Java/Spring Boot, Python, SQL Server). Don't explain functions, async/await or REST. Explain only what's new. Diagram first, text after, short sentences.

**Phase B · Gate.** 5–8 application questions, not memory ones: predict, what-if, order the flow, read code, choose and justify. Ask them one at a time. To pass I need:
- 80% or more correct.
- A 5-line explanation in English of what we'll build and why this way.
- Three checks: I know what each tool does, I know why the files are laid out like this, I know what I'll review in the PR.

If I fail, re-explain only what I failed, with a different example and a new diagram, then new questions on that. **Emergency key:** if I say "emergency key", give me the prompt anyway, but log it as comprehension debt in `docs/progress.md`. The batch doesn't count as done until I pay the debt (I pass the questions later).

**Phase C · Build.** First show me the full build prompt (section 1.4) and wait. Tell me which model and effort to set for this batch (section 10). When I say "go", build it:
- Small commits, tests first where it makes sense.
- Nothing outside the scope.
- No new tools without asking me.
- Open one PR with a demo note: what to look at, in 15 minutes.

While you build, I read the PR as it grows. If I ask something mid-build, answer briefly and keep going.

**Phase D · Close.**
1. **PR review with me**, using the checklist in section 9. If there's a file I can't explain, we stop and explain it before the merge.
2. **2 minutes in English:** I explain the batch out loud (I'll record it). Then give me 3 short corrections on my English: grammar, vocabulary and a more natural phrasing.
3. **`docs/learning.md`:** add what I learned in 5–10 bullets, plus the interview question this batch answers.
4. **Anki:** write the gate questions (with answers) to `docs/learn/<batch>-anki.csv` (front;back).
5. **Trazo:** list 3–6 key concepts in `docs/learn/<batch>-trazo.md`. I paste them into Trazo, my study app, for spaced repetition.
6. **Times:** ask me for study, build and review time, plus my weekly Claude usage %. Write them to `docs/progress.md`.
7. **Next-batch block:** name, model, effort, estimated date, deadline, dependencies. Then stop.

### 1.4 What a build prompt contains
- Model and effort (from section 10).
- Context: what already exists and which batch this is.
- Decisions and why: the same ones as in the lesson.
- Files: the exact tree from the lesson.
- Tests, including the ones from "what can fail".
- Acceptance criteria, verifiable.
- Out of scope: what not to do.
- Demo note.

One batch, one prompt. If a batch is too big, split it into two prompts with a passing test in between. Never one giant PR.

### 1.5 Release checklist (end of every version: batches 1.8, 2.7, 3.5, 4.5)
- Post series: 1.0 = teaser, 1.1 and 2.0 = build, 3.0 = launch. "Deep dive" and "result" posts come after 3.0.
- **3.0 is the launch and must pass the 🧲 Imán standard** (earlier versions don't need it):
  1. One-line hook.
  2. Wow moment in the first 3 s of a 30 s video.
  3. Public demo without signup.
  4. One memorable metric, measured, never invented.
  5. A news tie-in.
  6. README, ADRs and tests ready for a technical test.
  7. Target companies named.
  8. Teaser, build and launch posts published.
  Write it to `docs/iman.md` during batch 4.5 and check every point with me.
- Release notes and README updated with metrics: quality, p95, cost per query, reliability.
- A 30-second video script: what to show, in order.
- Draft posts in `docs/posts/<version>.md`:
  - LinkedIn: English first, Spanish below, a hook in the first line, link to the demo in the first comment.
  - X: a 3–5 tweet thread in English.
- I publish the same day, and I edit the drafts in my own voice. Don't invent numbers: use only what we measured.
- Weekly rhythm: Tuesday post = PetrIA progress (draft it from that week's thesis in `docs/learning.md`). Thursday post is for my background tracks, not PetrIA.

---

## 2. Who I am (public summary)

- A senior full-stack developer (Next.js, TypeScript, Node/Express, Java/Spring Boot, Python, SQL Server) who has already shipped a company-wide RAG assistant.
- Very visual: I need to see flows and anatomy to understand. When you name a tool without a one-line summary, I get lost.
- I aim to be a "level 3" AI engineer: not just a prompt and an API call, but RAG and tools with an eval set, plus tracing bad answers to their source, human approval for risky actions, and production failures turned into tests. PetrIA must show all of that.
- **Language:**
  - Talk to me in English and correct my English. Code, docs, commits and PRs are in English.
  - Exception: the lesson's explanations of new concepts can be in Rioplatense Spanish when that makes the idea clearer, with technical terms in English. Ask me which I prefer if unsure.
- PetrIA is my principal track and gets priority on Claude usage. If I'm close to a limit, tell me which upcoming batches can be done with a lighter model and which can't (see section 10).
- Until my PC arrives I work from a tablet: you run the code in your environment, I review PRs from the GitHub app, and heavy data work goes to Colab. The 100M-row tests wait for the PC.
- **Three tracks.** PetrIA is the principal track. Two background tracks (a separate app, and a commercial showcase after PetrIA) run in other sessions and other repos and never touch this repo or these chats. My open-source scaffolding CLI **Alawys** (`npm create alawys`) starts after PetrIA; see section 7.6. If I mention a background track in a PetrIA chat, keep it to one line and bring me back to the current batch.

---

## 3. The product

**PetrIA** is a web map of Vaca Muerta with every real well, an estimate of how much oil an undrilled zone would produce (P10, P50, P90), and an assistant that answers citing the official data, or says it doesn't know.

- **Who it's for:**
  - An analyst at an operator or consultancy who compares zones without spreadsheets.
  - A field engineer (from 1.1): daily reports, WhatsApp alerts, voice.
  - A recruiter, who sees a real product with real data online.
- **What it solves:**
  - Productivity by zone is computed by hand, in Excel, without a range.
  - The official data is raw, with errors and no map.
  - Asking for the best wells requires SQL.
- **What it is not:** it doesn't discover oil and doesn't recommend investments. It's a non-commercial demo with public data, and the screen says so.
- **One-liner for interviews:** "I built PetrIA: it estimates the productivity of every Vaca Muerta zone with a P10/P50/P90 range, validated by spatial blocks so it can't cheat, and an assistant that answers citing the official data or says it doesn't know."

---

## 4. The domain, in 2 minutes

- **Vaca Muerta** is a source-rock formation in Neuquén, about 3 km deep. Oil and gas are trapped in the rock itself.
- **Quintuco** is the layer above it. It's shown on the map but not modeled.
- **How a well is drilled:** vertically down to the formation, then horizontally along it (the lateral), then fractured in stages along the lateral.
- **Productivity:** we use cumulative oil in the first 12 months, the standard way to compare wells.
- **P10 / P50 / P90:** a range, not one number. With quantile regression, P10 is the 10th percentile of the predicted distribution (pessimistic) and P90 the 90th (optimistic). Note that the industry convention is sometimes the reverse; state the convention in the UI and the README.
- **Arps decline (1.1):** the classic curve of how a well's production drops over time.
- **Sigla vs idpozo:** a physical well (sigla) can have several idpozo records. Treat the physical well as the unit.

---

## 5. Verified data facts (don't contradict these)

These are verified facts about the **Capítulo IV** production dataset (Secretaría de Energía):

- The file has **26 columns**.
- **Some rows have latitude and longitude swapped.** Validate them against a Neuquén bounding box and flag or fix them.
- There are **85,858 idpozo but ≈ 78,592 siglas**. The cause of the difference is **not verified**: don't claim one. Group by physical well (sigla) and document the open question.
- **License:** the portal says the license is not specified. So it's a non-commercial demo that cites the source, and this goes in an ADR.
- **The host `datos.energia.gob.ar` timed out** from both Colab and GitHub runners. In 1.0 I download the files by hand and upload them; automatic download is attempted in 3.0 (from AWS).
- The old repos (now renamed `-v0` and archived) may be read **only** to copy verified data facts, never code.

> Precision note (from `docs/data-sources.md`): the 26-column file is the well
> **registry** ("Capítulo IV - Pozos"); the unconventional **production** file
> has 40 columns. The swapped coordinates are a verified symptom with an
> inferred cause.

---

## 6. Decisions already taken

| Question | Decision | Why |
|---|---|---|
| Does Quintuco count? | Only Vaca Muerta goes into the model; Quintuco is shown on the map | Different rocks produce differently; can be added later |
| How is a well identified? | Physical well by `sigla`, with its `idpozo` records | Avoids extra wells and train/test leakage |
| How do files arrive? | 1.0: manual upload. 3.0: automatic download | The site doesn't answer from the cloud today |
| Rebuild the repos? | New repos; old ones renamed `-v0` and archived | Clean start; verified data facts are copied |
| What's predicted? | Oil in the first 12 months; gas added in 1.1 | Standard measure to compare wells |

---

## 7. Architecture

### 7.1 Repos
- **`petria-web`:** Next.js + TypeScript, MapLibre GL, later Three.js and the design system. Also holds `docs/` (plan, progress, learn, posts, ADRs).
- **`petria-ingest`:** Python, pandas, SQLAlchemy, Alembic, RabbitMQ publisher. Writes the `geo` schema.
- **`petria-ml`:** Python, LightGBM with quantiles, spatial cross-validation, H3, MLflow. Reads `geo`, writes `ml`.
- **`petria-api`:** Java 21, Spring Boot 3, JPA, Flyway, OpenAPI; Keycloak from 1.1. Writes `platform`.
- **`petria-assistant`:** Python, FastAPI, LangGraph over Claude, pgvector. Writes `rag`.
- **`platform-kit`** (from 2.0): NestJS. Holds the notification-service, voice-gateway, metering and load-lab, reused by all my future projects (documented exception in an ADR).

### 7.2 Database
- Neon Postgres with PostGIS and pgvector.
- **4 schemas, one writer each:** `geo` (ingest), `ml` (ml), `platform` (api), `rag` (assistant).
- This is enforced by **database roles**, not by convention: a test proves `petria-ml` cannot write to `geo`.

### 7.3 Two rules that hold everything
1. The browser only talks to `petria-api`.
2. Each service writes only to its own schema.

### 7.4 Flow of one well (1.0)
A CSV row from Capítulo IV goes through these steps:
1. `petria-ingest` cleans it, groups it by sigla, loads it idempotently into `geo` and publishes "new data" on RabbitMQ.
2. `petria-ml` builds the features, retrains and writes a P10/P50/P90 prediction per H3 hexagon to `ml`.
3. `petria-api` serves it.
4. `petria-web` draws it on the map.

The assistant answers through `petria-api`, using three tools (allowed SQL, the detector, documents) and citing the source, or abstaining.

### 7.5 Deploy
- Render for the services, Neon for the database.
- AWS in 3.0: S3, SQS, Lambda; SES for email from 2.0.
- No secrets in repos: `.env.example` only.

### 7.6 Design for extraction (new in v12.2)
From VitalIA on, every project starts with **Alawys**, my open-source scaffolding CLI. PetrIA is the source of two things, so build them to be extracted later, without extracting or publishing anything now:
- **The skeleton (batch 0.1)** becomes Alawys's `petria` preset: Dockerfiles, `docker-compose.yml`, CI (lint, tests, gitleaks, Semgrep, pinned actions, Dependabot), `.env.example`, the ADR template. Keep it generic: project and service names live in one place, nothing PetrIA-specific inside the CI or Docker files.
- **Four modules** become standalone packages when a second project needs them:

  | Module | Batch | Future package | Needed by |
  |---|---|---|---|
  | notification-service (WhatsApp → call → email) | 3.1–3.2 | `@alawys/notify` | PetrIA Guard (Apr 2027) |
  | Model router + semantic cache + cost cap | 2.4 | `@alawys/llm-router` | AeroScan (Jun 2027) |
  | Evals-in-CI workflow | 2.6 | `@alawys/evals-action` | AgrIA Sat (Jul 2027) |
  | Usage & quotas | 3.4 | `@alawys/usage-meter` | Antena Ops (Aug 2027) |

  For each one: a small public interface, no imports from PetrIA's domain code (wells, sigla, H3), its own tests and a short README section. The evals workflow is a reusable GitHub workflow with inputs, not a copy-paste job.
- In batch 4.5, write `docs/alawys-preset.md`: what in the skeleton is generic, what is PetrIA-specific, and the public interface of the four modules. This fits inside batch 4.5's hours.
- Don't publish anything to npm, PyPI or the GitHub Marketplace from PetrIA.

---

## 8. Versions (estimated dates at 10–11 h/day; the deadline is the plan's limit; ≈ 195 h in total)

| Version | Estimated | Deadline | Hours | What you see |
|---|---|---|---|---|
| 1.0 MVP | 21–25 Nov | 1 Dec | ≈ 47 h (with wave 0) | Real wells, concessions, productivity heat map, P10/P50/P90 detail, chat that cites the source |
| 1.1 Product | 25–30 Nov | 12 Dec | ≈ 48.5 h | Well value, Arps decline, daily-report reader, login per company, gas |
| 2.0 Platform | 30 Nov – 4 Dec | 22 Dec | ≈ 40 h | WhatsApp, email, calls with fallback, voice, usage and quotas, Storybook |
| 3.0 Production | 4–9 Dec | 5 Jan 2027 | ≈ 58 h | load-lab, SLOs, feature flags, backup drill, AWS ingest, AR well, phone scanner, Wokwi wellhead, GPS |

If we're slower than estimated, the deadline absorbs it. We never cut depth: cert window 1 moves instead.

---

## 9. Rules and PR checklist

### Rules
- **Security:**
  - No secrets in repos; `.env.example` only.
  - No personal data in public repos.
  - Actions pinned to SHA; gitleaks and Semgrep in CI.
- **Labels:**
  - Simulated data is labelled as simulated.
  - No third-party logos.
  - A "non-commercial demo with public data" notice, and "not investment advice".
- **Voice agents** say they are AI and that the call is recorded. No voice cloning.
- **Load tests never hit the real LLM API:** use a simulated LLM.
- **Spending caps** on every paid API (ElevenLabs, Twilio, WhatsApp, SES, Anthropic).
- **Algorithm spots:**
  - The ones marked "by hand, no AI" I write myself: you give me the problem, the expected complexity and 2–3 tests, then you review my code.
  - The ones marked "with AI" you propose, and I validate out loud the complexity, the edge cases and the trade-offs.
  - Log each spot in `docs/learning.md` with the interview question it answers.
- **Scope:** if something new looks necessary, ask me, explain why, and log the decision.
- **Extraction-ready, not extracted:** follow section 7.6; never add work to extract or publish packages during PetrIA.

### PR checklist (we go through it together)
- [ ] Are all the files from the lesson's tree there, and nothing unexpected?
- [ ] Do the "what can fail" tests exist and pass?
- [ ] Is the schema/role boundary respected?
- [ ] Are there secrets, personal data or hardcoded URLs?
- [ ] Is there anything I can't explain? If yes, explain it before the merge.
- [ ] Does the demo note match what I see?
- [ ] (0.1, 2.4, 2.6, 3.1–3.4) Is the piece extraction-ready per section 7.6: generic, small interface, no domain imports?

---

## 10. The 28 batches

Models:
- **Opus** = Opus 5.5: logic, data, ML, AI, security.
- **Fable** = Fable 5.2: everything visual. It has its own weekly limit.
- **Sonnet** = Sonnet 5.5: mechanical work.

If I'm short on usage, a "high" Opus batch can drop one effort level. The "xhigh" ones never drop.

| # | Batch | Repos | h | Estimated | Deadline | Model · effort | Depends on |
|---|---|---|---|---|---|---|---|
| 0.0 | Onboarding | — | 1.5 | 21 Nov | 21 Nov | Opus · high | — |
| 0.1 | Repos, CI & Docker | all 5 | 3 | 21 Nov | 21 Nov | Sonnet · medium | 0.0 |
| 0.2 | Database & roles | ingest | 2.5 | 21 Nov | 21 Nov | Opus · high | 0.1 |
| 1.1 | Ingest & cleaning | ingest | 7 | 21–22 Nov | 22–23 Nov | Opus · xhigh | 0.2 |
| 1.2 | Messaging & concessions | ingest, ml | 3 | 22 Nov | 23 Nov | Sonnet · high | 1.1 |
| 1.3 | Features & baseline | ml | 6 | 22–23 Nov | 24 Nov | Opus · xhigh | 1.1 |
| 1.4 | P10/P50/P90 detector | ml | 7 | 23 Nov | 25–26 Nov | Opus · xhigh | 1.3 |
| 1.5 | Read API | api | 4 | 23–24 Nov | 27 Nov | Opus · high | 1.1, 1.4 |
| 1.6 | Map | web | 5 | 24 Nov | 28 Nov | Fable · xhigh | 1.5 |
| 1.7 | Assistant with citations | assistant, api | 6 | 24–25 Nov | 29–30 Nov | Opus · xhigh | 1.4, 1.5 |
| 1.8 | Production 1.0 + release | all 5 | 2 | 25 Nov | 1 Dec | Sonnet · high | 1.6, 1.7 |
| 2.1 | Well value & decline | ml, api | 7 | 25–26 Nov | 2–3 Dec | Opus · high | 1.8 |
| 2.2 | Daily-report reader | ingest | 7 | 26 Nov | 4–5 Dec | Opus · high | 1.8 |
| 2.3 | Login & companies | api, web | 8 | 26–27 Nov | 6–7 Dec | Opus · xhigh | 1.8 |
| 2.4 | Serious AI + feedback loop | assistant | 8.5 | 27–28 Nov | 8 Dec | Opus · high | 1.7 |
| 2.5 | Quality | all 5 | 6 | 28–29 Nov | 9 Dec | Sonnet · high | 2.1–2.4 |
| 2.6 | Observability, evals in CI & security | all 5 | 8 | 29 Nov | 10–11 Dec | Opus · high | 2.5 |
| 2.7 | 1.1 screens + release | web | 4 | 29–30 Nov | 12 Dec | Fable · high | 2.6 |
| 3.1 | notification-service | platform-kit | 8 | 30 Nov | 13–14 Dec | Opus · high | 2.7 |
| 3.2 | Real channels | platform-kit, api | 9 | 1 Dec | 15–16 Dec | Opus · high | 3.1 |
| 3.3 | voice-gateway | platform-kit | 10 | 1–2 Dec | 17–19 Dec | Opus · xhigh | 3.1 |
| 3.4 | Usage & quotas | api, platform-kit | 6 | 2–3 Dec | 20 Dec | Sonnet · high | 2.3 |
| 3.5 | Design system + 2.0 release | web | 7 | 3–4 Dec | 21–22 Dec | Fable · high | 3.2–3.4 |
| 4.1 | load-lab | platform-kit | 14 | 4–5 Dec | 23–25 Dec | Opus · high | 3.5 |
| 4.2 | Operations | all 5 | 12 | 5–6 Dec | 26–28 Dec | Opus · high | 4.1 |
| 4.3 | Ingest on AWS | ingest | 10 | 6–7 Dec | 29–30 Dec | Opus · high | 4.2 |
| 4.4 | Physical layer | web, ingest | 14 | 7–8 Dec | 31 Dec – 3 Jan | Fable · high | 4.2 |
| 4.5 | Scale report + 3.0 release | all 5 | 8 | 9 Dec | 4–5 Jan | Sonnet · medium | 4.3, 4.4 |

### Batch details

**Wave 0 · Foundations**
- **0.0 Onboarding:** a study session with no code. What PetrIA is, the journey of one well, repos and versions. It ends with these 5 questions:
  1. An undrilled spot is 2 km from ten producing wells. What does PetrIA show there, and why a range and not one number?
  2. Walk one Capítulo IV row to a point on the map, naming repos and schemas.
  3. `petria-ml` has a bug and tries to write to `geo`. What happens, and what stops it?
  4. Why would counting wells by `idpozo` make the model look better than it is?
  5. I ask the chat about a well that doesn't exist in the data. What must it answer, and why?
- **0.1 Repos, CI & Docker:**
  - The 5 repos with a skeleton, README and `.env.example`.
  - A Dockerfile per service, and a `docker-compose.yml` in `petria-web` that brings up Postgres + PostGIS + pgvector and RabbitMQ locally, so the whole stack runs with one command. Render builds from the same Dockerfiles.
  - CI with lint, tests, gitleaks and Semgrep; actions pinned to SHA; Dependabot.
  - Keep the skeleton generic (section 7.6): it becomes Alawys's `petria` preset.
  - ADRs 0001–0005: the decisions in section 6, plus the license.
- **0.2 Database & roles:** Neon with PostGIS and pgvector, the 4 schemas, one role per service, the first migration, and the test that proves `petria-ml` cannot write to `geo`.
  - Learn: GRANT, and USAGE vs SELECT.

**Wave 1 · 1.0 MVP**
- **1.1 Ingest & cleaning:** read the files, apply the Neuquén bounding box (catches swapped lat/long), group by physical well (sigla), load idempotently, write a data-quality report.
  - Learn: pandas, SQLAlchemy, Alembic, idempotency (`INSERT … ON CONFLICT`), PostGIS.
  - **By hand, no AI:** a hash map for the well index.
- **1.2 Messaging & concessions:** RabbitMQ with the "new data" event, and the concession polygons loaded into PostGIS.
- **1.3 Features & baseline:** the 12-month target, features known at drilling time (as-of, no leakage), neighbours, and a KNN baseline.
  - **By hand, no AI:** a sliding window and binary search.
  - **With AI:** a k-d tree.
- **1.4 P10/P50/P90 detector:**
  - LightGBM with quantile objectives and spatial block cross-validation.
  - Anti-cheating tests: no well appears in both train and test, and no feature from the future.
  - H3 hexagons and MLflow model registry.
- **1.5 Read API:** endpoints for wells, well detail, hexagons and concessions, with OpenAPI and read-only roles.
- **1.6 Map:** MapLibre with wells, heat and concession layers; a detail panel with P10/P50/P90; procedural loading.
- **1.7 Assistant with citations:** LangGraph with 3 tools (allowed SQL, detector, documents), citations, abstention and 20 evals.
- **1.8 Production 1.0:** deploy on Render + Neon, README with metrics, video script, release notes and the release checklist (1.5).

**Wave 2 · 1.1 Product**
- **2.1 Well value & decline:**
  - Revenue in USD and ARS, royalties, costs, present value, payback and break-even price.
  - Arps curve with P10/P50/P90; gas at 12 months.
  - Every assumption is visible and editable.
- **2.2 Daily-report reader:** a PDF, Excel or photo becomes validated data (Claude vision + structured output), with human review before saving.
- **2.3 Login & companies:** Keycloak (OIDC), several companies isolated in the same database (multi-tenant, RLS), zones saved per user.
  - **With AI:** a stack for undo in saved zones.
- **2.4 Serious AI + feedback loop:** 40–60 evals, structured output, Batch API, model router, semantic cache and a cost cap per company. The router, cache and cap sit behind one small interface (future `@alawys/llm-router`).
  - **Feedback loop:** a 👎 button in the chat stores the conversation (question, retrieved context, tool calls, answer). A small triage screen lets me label it as a retrieval, model or tool failure, and one click turns it into a new eval case. Every production failure becomes a test.
  - **With AI:** an LRU for the cache.
- **2.5 Quality:** Pact contracts between services, Playwright, axe in CI, Lighthouse, Spanish/English.
- **2.6 Observability, evals in CI & security:**
  - End-to-end OpenTelemetry. Each assistant answer has spans per step (retrieval, model, each tool), with what was retrieved, tokens, cost and latency, so a bad answer can be traced to the step that failed.
  - Evals run in CI on every PR that touches the assistant (with a fixed model and temperature 0), as a reusable GitHub workflow with inputs (future `@alawys/evals-action`). The CI fails if the score drops below the main branch's score minus a small tolerance; the PR shows the before/after table.
  - A first k6 test with a simulated LLM, MCP, and a STRIDE threat model.
  - **With AI:** a token bucket for rate limiting.
- **2.7 1.1 screens + release:** polish the new screens (value, decline, reports, login), plus empty states and the release checklist.

**Wave 3 · 2.0 Platform**
- **3.1 notification-service:** NestJS in `platform-kit`, with templates, a queue, idempotency (also on callbacks), retries and spending caps. Extraction-ready (future `@alawys/notify`).
- **3.2 Real channels:**
  - WhatsApp (Meta Cloud API).
  - Email with SES, with SPF, DKIM and DMARC.
  - Calls (Twilio).
  - Fallback: WhatsApp → call → email.
- **3.3 voice-gateway:** "PetrIA, show me the best wells in Loma Campana". Streaming, barge-in, confirmation before acting, and the AI and recording disclosure.
- **3.4 Usage & quotas:** queries, tokens and cost per company, with a warning near the quota. No billing. Extraction-ready (future `@alawys/usage-meter`).
- **3.5 Design system + 2.0 release:** Storybook with PetrIA's components, the channel and voice screens, and the release checklist.

**Wave 4 · 3.0 Production**
- **4.1 load-lab:**
  - k6 with persona bots and a simulated LLM.
  - Data at 10k and 1M rows (100M with the PC).
  - Chaos and Grafana; percentiles explained.
- **4.2 Operations:** SLO and error budget, feature flags, expand/contract migrations, a backup drill, graceful degradation and runbooks.
- **4.3 Ingest on AWS:** S3, SQS, Lambda and least-privilege IAM. Automatic download if the official site answers from AWS.
- **4.4 Physical layer:**
  - The well in AR (USDZ, AR Quick Look).
  - The phone as a report scanner.
  - A wellhead in Wokwi over MQTT.
  - GPS: "wells near me".
- **4.5 Scale report + 3.0 release (the launch):**
  - The Scale report.
  - `docs/iman.md`: the 8-point Imán checklist, checked with me (section 1.5).
  - `docs/alawys-preset.md` (section 7.6).
  - A technical article.
  - The video script.
  - The 3.0 release notes and the release checklist.

---

## 11. Risks (and their defence)

| Risk | Symptom | Defence |
|---|---|---|
| Swapped lat/long | Wells appear in the ocean or in another province | Neuquén bounding box in ingest + quality report |
| idpozo vs sigla | Too many wells; suspiciously good metrics | Group by sigla; a test that no physical well is in both train and test |
| Leakage from the future | Validation looks great, reality doesn't | As-of features; a test that fails if a feature is dated after drilling |
| Spatial leakage | Neighbouring wells in train and test | Spatial block CV, compared with random CV in the README |
| Assistant invents | Answers without a source | Mandatory citation, abstention, evals that punish invention, evals in CI, 👎 → new eval case |
| Source site down | Ingest can't download | Manual upload in 1.0; automatic download retried from AWS in 3.0 |
| Costs | API bills grow | Caps per provider and per company; simulated LLM in load tests |
| Hitting Claude limits | Batches stall | Keep Sonnet batches mechanical; on limit days I study, do Trazo, Anki or the by-hand algorithms |
| I don't understand something | I nod and move on | The gate; emergency key with logged debt |
| Background tracks eat credits | PetrIA batches stall on limits | PetrIA has priority; background tracks pause first. Background work never runs in a PetrIA chat |
| Over-engineering for extraction | Batches grow beyond their hours | Extraction-ready means clean boundaries only; no packaging, no publishing, no extra abstractions |

---

## 12. Glossary (1.0)

| Term | What it is | Analogy |
|---|---|---|
| PostGIS | Geography types and queries inside Postgres | Spatial functions in SQL Server, but richer |
| H3 | A grid of hexagons covering the map; each one gets a prediction | Map tiles, but hexagonal and with equal areas |
| Quantile regression | Predicting percentiles instead of one value | A forecast with a pessimistic and an optimistic case |
| Spatial CV | Testing on whole zones the model never saw | Testing a feature on a client that wasn't in staging |
| Idempotent load | Loading the same file twice leaves the same result | Upsert instead of insert |
| RabbitMQ | A message broker; services react to events | An event emitter between processes |
| LangGraph | A graph of steps and tools for an LLM agent | An Express middleware chain, but for an agent |
| pgvector | Similarity search by meaning inside Postgres | An index, but semantic |
| Evals | Automated tests for AI answers | Unit tests for an assistant |
| Docker / compose | Each service in a container; compose starts them all together | A packaged runtime per service; `npm run dev` for the whole stack |
| Trace span | One timed step of a request (retrieval, model call, tool) | A row in a request log, but nested and with cost |
| MapLibre | Interactive maps in the browser | Google Maps JS, but open |
| Abstention | The assistant says "I don't know" when there's no source | Returning 404 instead of inventing data |
