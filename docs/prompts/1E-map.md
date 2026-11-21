# Build prompt 1E: The map

**Run with:** Fable 5.2, effort high · **Planned:** 12.5 h · **Repo:** `PetrIA` (the web app)
**Before you paste this:** the API runs and returns wells and cells. You have seen the 1E lesson (map layers, uncertainty on a map) in the Learning Pack.

---

You are the builder for batch 1E of PetrIA: the map, the part people will see first. Work in the `PetrIA` repo on the branch the session names. Never push to main.

## Step 0: create the agent
Create `.claude/agents/petria-frontend.md` (Next.js, TypeScript, MapLibre GL, accessibility rules, `model: opus` or the tier the owner chooses). Show it and wait for OK.

## Read first
`CLAUDE.md`, `docs/roadmap.md` (1E), `docs/design.md`, the API contract (`docs/openapi.json` in `PetrIA-BE`).

## Step 1: three visual directions, then STOP
Before any code, produce **three** short visual directions as a single HTML page (published as an artifact): palette, type, how the heat map shows uncertainty, one mock of the cell detail card. Each direction must be specific to oil data and a map, not a generic dashboard. Recommend one. The owner chooses.

## Step 2: build (after the owner chooses)
1. Next.js + TypeScript app; MapLibre GL with two base maps (satellite and OpenStreetMap) and a switch.
2. Layers: wells (clustered when zoomed out), heat map of the cells, concessions outline. Each layer has a toggle and a legend.
3. The heat map must show uncertainty, not only the P50: for example colour = P50, opacity or hatch = width of the P10–P90 band. Explain the choice in the UI legend in one sentence.
4. Cell detail card: P10, P50, P90 as a range bar, the confidence flag, the number of nearby wells used, the source and date of the data.
5. Well detail card: name, operator, first production month, a small production line chart.
6. Progressive loading: request only what is in the viewport; show a loading state and a clear error state; never block the page.
7. A permanent, visible line: "Estimate from public data. Not drilling or investment advice." Label any simulated data.
8. Accessibility: keyboard navigation for the toggles and cards, visible focus, contrast AA, a text alternative to the map's key numbers.
9. Playwright test: load the page, click a cell, see P10/P50/P90; axe check with no serious violations.
10. Phone and tablet widths work (the owner uses an iPad).

## Rules
No secrets; only `NEXT_PUBLIC_` variables for public values. Public repo. Keep CI green. Plain-language explanations; no unexplained jargon.

## Done when
`npm run build` and `npm test` pass; the Playwright test passes; Lighthouse performance and accessibility numbers are recorded in `docs/learning.md` (the measured ones, whatever they are); a screenshot at tablet width is saved in `History/`.

## Close the batch
`teach-back`, `handoff`; break-it (for example, hide the uncertainty and see what the map suggests to a reader); explain-back; pull request, no merge. Announce 1F: Opus 5.5 effort high for the assistant logic; the chat panel later with Fable 5.2 medium. Remind the owner to check plan usage after this Wow batch.
