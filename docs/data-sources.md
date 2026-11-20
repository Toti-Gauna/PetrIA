# Data sources: what is verified

Status: run 1 of the verification notebook, 2026-11-20 (about 17:05 to 17:17
UTC, in Google Colab). **Only catalog metadata is verified. No data file has
been read yet**, so columns, coordinates, keys and row counts are still
unverified.

Evidence labels:
- **Verified**: read from the official catalog API (`datos.gob.ar`, CKAN
  `package_show`) in run 1.
- **Not confirmed**: a claim from the research report that run 1 could not
  check, or that run 1 contradicts.

## The four dataset families
| Family | Verified dataset (slug on datos.gob.ar) | License (official field) | Declared update |
|---|---|---|---|
| Production per well, Capítulo IV | `energia-produccion-petroleo-gas-por-pozo-capitulo-iv` | `No se especificó la licencia` | Monthly (`R/P1M`) |
| Fracturing, Adjunto IV | `energia-datos-fractura-pozos-hidrocarburos-adjunto-iv` | `No se especificó la licencia` | Daily (`R/P1D`) |
| Concessions | `energia-produccion-hidrocarburos---concesiones-explotacion` | `No se especificó la licencia` | Monthly (`R/P1M`) |
| Well shapefile | A resource of the production dataset (format `SHP`) | same as production | same as production |

The slugs `produccion-de-petroleo-y-gas-por-pozo` and
`datos-de-fractura-de-pozos-adjunto-iv` returned **404** on `datos.gob.ar`. The
`energia-...` slugs above are the ones that exist there.

## Verified facts, by dataset
**Production (Capítulo IV).** About 50 resources. Dataset first issued
2017-01-20; catalog metadata last modified 2026-07-27.
- One CSV per year, 2006 to 2026, plus a parallel set named
  "(DDJJ abiertas y cerradas)" for each year.
- Separate files for non-conventional production, the wells registry (CSV and
  shapefile, both named "Capítulo IV - Pozos"), a list of wells loaded by
  operators, and aggregated series.
- **New find:** "Padrón de Pozos de Capítulo IV con fecha de primera
  producción", a wells list with the date of first production. This matters for
  the detector: the 12-month window starts there.
- **Duplicate names:** 2025 and 2024 each appear twice (different ids, similar
  dates). Which one is canonical is unknown.
- No resource reports a file size.
- The newest modification is 2026-07-27, about four months before the run,
  although the declared frequency is monthly. Which months the files actually
  cover is unknown.

**Fracturing.** One CSV ("Actualización diaria", modified 2026-07-27) and one
PDF infographic. First issued 2019-10-25.
- Not confirmed: the research said "last modified 16-09-2026". The catalog says
  2026-07-27.

**Concessions.** Two resources: a shapefile ZIP and a CSV, both modified
2026-07-01 (dataset `modified` 2026-05-18), plus a link to an external map
viewer. The "Lotes de Explotación", "Permisos de Exploración" and "Cuencas
Sedimentarias" datasets exist (seen in search results, also with no license),
but their resource lists could not be read: the catalog returned a server error
or timed out.

**Other.** "Producción de Petróleo y Gas (SESCO)" exists and is a different,
aggregated dataset. Do not confuse it with Capítulo IV.

## The license, in plain words
The official catalog says **"No se especificó la licencia"** for every dataset
seen (production, fracturing, concessions, lots, permits, basins, SESCO). The
research claim "CC-BY 4.0" from a third-party project is **not supported** by
the official metadata. [ADR-0005](adr/0005-data-license-unconfirmed.md) stands:
a non-commercial demo that cites the source and labels the data.

Open: whether `datos.gob.ar` has portal-wide terms of use that apply by
default. Not verified. This is not legal advice.

## What run 1 could not do
- **The file host did not answer.** The download links point to
  `datos.energia.gob.ar` over plain HTTP. From Colab, every connection to it
  timed out (ports 80 and 443). No file was downloaded.
- The catalog `datos.gob.ar` answered, but unevenly: one 500 error and two read
  timeouts on a few requests.
- The run took 12 minutes, mostly waiting on timeouts. Notebook v2 stops
  waiting on a host that does not answer.

## Still unverified (needs the files)
Real column names, row counts, file sizes, the coordinate system of the
shapefiles, whether `coordenadax` is longitude or latitude, the distinct values
of the formation and resource columns, duplicate (`idpozo`, `anio`, `mes`)
rows, whether `idpozo` is per well or per well-and-formation, how fracturing
rows join to wells, and the latest month of data.

## Next step
Run 2: download the six files on your own device and upload them to the
notebook (links in the
[notebook README](https://github.com/Toti-Gauna/PetrIA-Ingest/blob/main/notebooks/README.md)).
