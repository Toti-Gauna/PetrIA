# Build prompts

One prompt per batch. Each one is meant to be pasted into a Claude Code session started in the right repo, with the model and effort written at the top of the file.

| Batch | File | Model · effort | Repo |
|---|---|---|---|
| 1B | [1B-ingestion.md](1B-ingestion.md) | Sonnet 5.5 · medium | PetrIA-Ingest |
| 1C | [1C-detector.md](1C-detector.md) | Opus 5.5 · high | PetrIA-ML |
| 1D | [1D-api.md](1D-api.md) | Sonnet 5.5 · medium | PetrIA-BE |
| 1E | [1E-map.md](1E-map.md) | Fable 5.2 · high | PetrIA |
| 1F | [1F-assistant.md](1F-assistant.md) | Opus 5.5 · high, then Fable 5.2 · medium | PetrIA-RAG, PetrIA |
| 1G | [1G-ship.md](1G-ship.md) | Fable 5.2 · medium | all |

## Why one prompt per batch, not one for the whole wave
Each batch depends on what the previous one produced (real tables, real metrics). A single prompt would ask the builder to guess. Each prompt also contains **stops**: the builder must pause for the owner's decision (the spec, the algorithm spots, the visual direction). The owner reads the written spec first, so nothing moves forward unexplained.

## How the loop works
1. Learn the concept in the Learning Pack (pictures, examples, plain words).
2. Pass the 3-question check for the batch.
3. Copy the batch prompt and paste it into Claude Code with the model named in the file.
4. The builder writes the spec and stops; the owner answers; the builder builds in small tested steps.
5. Explain-back, pull request, written review, merge.

These prompts contain no secrets and no personal data. Facts about the data live in `docs/data-sources.md`; the prompts point to it instead of copying numbers.
