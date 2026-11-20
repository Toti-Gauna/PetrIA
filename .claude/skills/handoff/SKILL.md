---
name: handoff
description: "Report work back in a fixed, tablet-friendly format and prepare a clean pull request. Use at the end of every task, before the lead presents it to the owner."
---

# Skill: Handoff

## Purpose
The owner reviews on a tablet and must be able to explain every change. A fixed
format makes review fast and honest.

## Report format
1. **Files changed:** a short tree, one line each saying what the file is for.
2. **Key code:** short blocks (about 10 lines), each followed by a plain
   explanation. Compare with the JavaScript or SQL Server equivalent when new.
3. **How to run or test it:** the exact command.
4. **What was tested:** the real result. Say what failed or was not tested.
5. **Risks and open questions.**
6. **Next batch:** its name and what it is (from `docs/roadmap.md`), the model
   and effort to use for it, the hours, and what the owner must do first. Say
   it every time a batch closes, so the owner can switch the model in time.

## Pull request rules
- One pull request per module or per day. The title is conventional
  (`feat:`, `fix:`, `docs:`, `chore:`).
- The body says: summary, what is included, review focus (two or three
  questions for the owner), what is not included.
- Never push to `main`, never merge, never change permissions, secrets or
  `CLAUDE.md`. The owner reviews in writing, then decides.
- No secrets, personal data or raw data files in the repository.
- Update `History/`, `docs/learning.md` and any ADR in the same pull request.
