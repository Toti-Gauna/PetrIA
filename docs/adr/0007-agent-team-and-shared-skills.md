# 0007. A team of specialist agents with shared skills

Status: Accepted (2026-11-20)

## Context
Building PetrIA is also a way to learn and to show how an agent system is
designed. Three goals:
1. Learn the stack by writing down each role's rules.
2. Build agents that can be reused in later projects.
3. Separate concerns: for example, an independent security review that cannot
   edit the code it reviews.

The owner already has a private library of agents (backend, frontend, security,
documentation and others). It is written in Spanish, uses model names from
another tool, and its backend agent targets Node/Express, not our Java and
Python services. We reuse its *method*, not its content.

## Options
A. **One general assistant does everything** (what we have today). Simple, but
   no separation of concerns and nothing reusable.
B. **Role agents with shared basic skills and per-role skills** (chosen).
   `petria-frontend`, `petria-backend`, `petria-data-ml`, `petria-security`,
   `petria-devops`, `petria-docs`, `petria-demo`, built just in time.
C. **Many autonomous agents coordinated by a supervisor agent.** More
   impressive, but more cost and delay per task, harder to evaluate, and more
   ways to fail. Not justified before we measure one team.

## Decision
Option B, with these rules:
1. Agents are named `petria-<role>` and live in `.claude/agents/`. Skills live
   in `.claude/skills/`. Both are adapted from the owner's library: translated
   to English, stack swapped, private details removed.
2. **Shared skills** every agent follows: `sdd` (spec before code),
   `discovery`, `evidence`, `handoff`, `teach-back`. Role skills are written
   only when a batch needs them, and each stays under one page.
3. **Least privilege.** `petria-security` is read-only. No agent can merge,
   push to `main`, or change permissions, secrets or `CLAUDE.md`.
4. **Model tier per role** follows the roadmap (Wow for what people see,
   Strong for subtle or safety-critical logic, Standard for plain building).
5. **The lead** (the main session) briefs each agent, explains its result to
   the owner, and opens the pull request. The owner reviews.
6. **Master copy in PetrIA first.** At the retro (batch A5) the final versions
   go back to the owner's library through a pull request.
7. **Evidence, not faith:** batch A6 plants bugs and measures whether the agents
   catch them.

## Consequences
+ The owner learns each layer by reading and editing its rules.
+ Reusable assets, and a clear story: one agent with guarded tools, fixed
  workflows around it, and evals.
- About 20 hours of the plan's slack (track A in the roadmap).
- More to explain in an interview, and more to maintain.
- **Unverified:** that Claude Code loads these files in later sessions, that
  the model aliases used here are valid, and that an agent can load a skill by
  name. The smoke test in the next session decides. Until then every agent
  file repeats its essentials inline.
