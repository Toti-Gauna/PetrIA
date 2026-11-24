# 0010. Manual file upload in 1.0; automatic download later

Status: Accepted (2026-11-23)

## Context
The files come from the Secretaría de Energía. In the verification runs
(2026-11-20) the file host did not answer from Google Colab; the owner downloaded
the files on their own device and uploaded them. Whether the host answers from
GitHub runners or from AWS is **not verified**. [ADR-0005](0005-data-license-unconfirmed.md)
also says raw data files are not committed to public repositories.

## Options
A. **Automatic download from the start.** Reproducible, but blocked if the host
   does not answer from where the code runs.
B. **Manual upload in 1.0, automatic download attempted in 3.0, from AWS**
   (chosen).

## Decision
Option B. In 1.0 the owner puts the files in a local folder (not committed) and the
ingestion reads them. In batch 4.3 the download is tried again from AWS, and the
manual path stays as a fallback.

## Consequences
+ 1.0 does not depend on a host we cannot reach.
+ Each file is identified by its size and SHA-256, so a load is repeatable.
- Monthly updates need a human until 4.3.
- Reproducing the data needs a download step by the person running the project.
