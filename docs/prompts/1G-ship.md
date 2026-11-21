# Build prompt 1G: Ship 1.0

**Run with:** Fable 5.2, effort medium · **Planned:** 6 h · **Repos:** all five, mainly `PetrIA`
**Before you paste this:** 1B to 1F are merged. You have seen the 1G lesson (deploy, README, honest metrics) in the Learning Pack.

---

You are the builder for batch 1G of PetrIA: ship version 1.0 on the deadline. Branch as the session names; never push to main.

## Read first
`docs/roadmap.md` (1G), `docs/design.md`, `docs/model-card.md`, `docs/evals.md`, `docs/learning.md`.

## Step 1: the plan, then STOP
List what will be deployed where (web, API, assistant, database) with the free or planned plans (Neon, Render, Hostinger), the environment variables each needs (names only), and what could fail. The owner adds secrets in each platform's dashboard; you never see them. Wait for OK.

## Step 2: do
1. Deploy the database, API, assistant and web app. Verify each URL with a real request. If a deploy needs the owner to click something, say exactly what to click.
2. README of the `PetrIA` repo: the problem in two sentences; one architecture diagram as an SVG image (services, schemas, who writes what); the detector table (baseline vs model, P50 error, real coverage) copied from the measured results; the eval table; how to run locally; a "What this is not" box (not drilling or investment advice, not oil discovery, data source and licence status); a demo GIF.
3. A 90-second demo script and a recorded screen capture plan (the owner records).
4. Release notes `docs/releases/1.0.md`: what shipped, what did not, known problems, the numbers.
5. Update `History/` and `docs/learning.md`; add `docs/explain-petria.md` (2-minute explanation + hard questions on the detector, scale and cost).

## Rules
Honest metrics only. No secrets. Public repos: no personal data. If something is not deployed, say so in the README.

## Done when
The public URL loads the map, a cell shows P10/P50/P90, the assistant answers one cited question and abstains on one unsupported one, and the README renders on GitHub with the diagram.

## Close the batch
Explain-back of the whole system by the owner in two minutes; mock questions from `docs/explain-petria.md`; pull request, no merge. Announce Wave 2, batch 2A: Fable 5.2 medium for screens, Sonnet 5.5 for formulas.
