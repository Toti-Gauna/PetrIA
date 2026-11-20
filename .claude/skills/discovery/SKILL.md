---
name: discovery
description: "Understand the task and the repository before deciding anything: read what exists, list what can be reused, ask only the questions that change the outcome, and declare every assumption. Use at the start of every request."
---

# Skill: Discovery

## Purpose
Most wrong work starts from a silent assumption about the stack, the paths or
the environment. Discovery turns assumptions into a visible list.

## Process
1. **Read before deciding.** Read the files the task touches. When the target is
   one file, read it whole, once.
2. **Inventory.** List what already exists that we can reuse: files, tables,
   tools, ADRs, earlier specs. Check before creating anything new.
3. **Ask little.** Ask only questions whose answer would change the outcome, at
   most three, each with a recommended default.
4. **Declare assumptions** in this block, before working:

```
Assumptions I am making (tell me if any is wrong):
- Stack / language: ...
- Where the files go: ...
- Environment (never production unless told): ...
```

## Rules
- Never assume the stack, the paths or the environment in silence.
- For anything that acts on a system (a scan, a request, a deploy), confirm the
  target and that it is the project's own development environment.
- If the repository contradicts the request, say so and propose a fix.
