# 0005. The data license is unconfirmed: non-commercial demo

Status: Accepted (2026-11-20)

## Context
The Day 2 research ([History](../../History/Day-02-Research-and-Replan/README.md))
found three conflicting statements about the license of the production
dataset (Capítulo IV): CC-BY 4.0 according to one third-party project, "not
stated" on a 2019 copy of the portal metadata, and "no license specified" for
a sibling dataset. No official page could be opened, so nothing is confirmed.

## Options
A. **Assume CC-BY 4.0** and build as if commercial use were allowed.
B. **Treat the license as unconfirmed**, run PetrIA as a non-commercial demo
   with attribution and labels, verify the license, and revisit (chosen).
C. **Do not use the data.**

## Decision
Option B. Rules:
- Cite the Secretaría de Energía as the source, with dataset names and the
  download date.
- Label every derived output as a PetrIA estimate, not endorsed by the source
  and not drilling or investment advice.
- Do not commit raw data files to public repositories. The code downloads
  them, so anyone can reproduce the load.
- Do not charge users.
- When verified, record each dataset's `license_title` from its CKAN metadata
  and supersede this ADR if the picture changes.

This is a project decision, not legal advice.

## Consequences
+ Low legal exposure, and honest about what we know.
- No monetization until the license is verified.
- Reproducing the data needs a download step instead of a ready-made file.
