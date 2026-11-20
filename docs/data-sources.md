# Data sources: what is verified

Status: after run 2 of the verification notebook (2026-11-20, 17:44 to 18:01
UTC, in Google Colab). Run 2 read **six real files** that the owner downloaded
by hand, plus the official catalog.

Evidence labels:
- **Verified**: read at the source (the catalog API, or inside a real file).
- **Inferred**: follows from verified data, but nobody checked it directly.
- **Unverified**: not measured yet.

The file host `datos.energia.gob.ar` did not answer from Colab, so the files
were downloaded on the owner's device and uploaded. See
[the notebook README](https://github.com/Toti-Gauna/PetrIA-Ingest/blob/main/notebooks/README.md).

## Files read (fingerprints)
Same bytes, same fingerprint: rerunning on these files must give the same
numbers.

| File (as saved) | Bytes | Rows or features |
|---|---|---|
| `capitulo-iv-pozos.csv` (registry) | 34,216,363 | 85,858 rows |
| `padrn-de-pozos-de-captulo-iv-con-fecha-de-primera-produccin.csv` | 1,172,135 | 86,386 rows |
| `produccin-de-pozos-de-gas-y-petrleo-no-convencional.csv` | 150,669,961 | 436,308 rows |
| `datos-de-fractura-...-adjunto-iv-actualizacin-diaria.csv` | 1,271,920 | 5,064 rows |
| `shapefile-de-pozos.zip` | 4,153,871 | 85,858 points |
| `produccin-hidrocarburos-concesiones-de-explotacin.zip` | 596,513 | 297 polygons |

SHA-256:
```
registry      a8a7c757a6167f4ef78cebec884d7f9077ed938b117ec8d0c8a87d2091022a71
padron        9b76ac85b960fc371f5786a573b5caadf81fbff8c6779f184bb8221df281770b
production    b10e752147193083908b3ec655816545e69a240e41be819c79e80c7ad6477f3c
fracturing    ff95734bf485b1a27ecb75e3a44dda3035e5496805cf3970a28d19802bf03026
wells shp     0d0d9ccd0ee7f8af33622cf48dda4a0fbb7635c630750fbda258c1412d9b3c21
concessions   5245af707af4a4f8154d7ea80908aa4992d57f3eff7f19a64a92bbee4b45e0eb
```

## The catalog (verified)
| Dataset (slug on datos.gob.ar) | License (official field) | Declared update |
|---|---|---|
| `energia-produccion-petroleo-gas-por-pozo-capitulo-iv` | `No se especificó la licencia` | Monthly |
| `energia-datos-fractura-pozos-hidrocarburos-adjunto-iv` | `No se especificó la licencia` | Daily |
| `energia-produccion-hidrocarburos---concesiones-explotacion` | `No se especificó la licencia` | Monthly |
| `...---lotes-explotacion` (shapefile and CSV) | `No se especificó la licencia` | Monthly |
| `energia-exploracion-hidrocarburos---permisos-exploracion` (shapefile, CSV, offshore tender) | `No se especificó la licencia` | Monthly |

The CC-BY 4.0 claim from the research is **not supported**:
[ADR-0005](adr/0005-data-license-unconfirmed.md) stands. Newest file changes
in the catalog date from July 2026. The catalog answered unevenly: one 500
error on the first try for the lots dataset, then success on retry.

## Facts from the files (verified)

**Registry ("Capítulo IV - Pozos").** 85,858 rows, 26 columns, one row per
`idpozo` (85,858 distinct) but only 78,592 distinct `sigla`.
- Columns: `sigla, idpozo, area, cod_area, empresa, yacimiento, cod_yacimiento,
  formacion, cuenca, provincia, cota, profundidad, clasificacion,
  subclasificacion, tipo_recurso, sub_tipo_recurso, gasplus, tipopozo,
  tipoextraccion, tipoestado, adjiv_fecha_inicio_perf, adjiv_fecha_fin_perf,
  adjiv_fecha_inicio_term, adjiv_fecha_fin_term, geojson, geom`.
- Coordinates are **not** in `coordenadax`/`coordenaday` columns. They are in
  `geojson` (a GeoJSON point, longitude first) and `geom` (hex-encoded binary
  geometry; it looks like EWKB with SRID 4326, not decoded yet).
- `formacion` has 79 distinct lowercase values, 2,815 empty; "vaca muerta"
  appears in 3,695 rows. `sub_tipo_recurso`: not reported 80,697, SHALE 3,532,
  TIGHT 1,629.
- The four `adjiv_fecha_*` date columns are empty in about 34,000 to 36,500
  rows each.

**Wells shapefile.** Points, 85,858 features (same count as the registry),
**EPSG:4326** (read from the `.prj` and by the reader). 22 attributes with
names cut to 10 characters, including `SIGLA` and `IDENTIFICA` (the `idpozo`
value, checked on sample rows). Values carry units as text (`"255 m"`).

**Production, unconventional.** 436,308 rows, **40 columns**, covering 5,214
`idpozo` and 5,029 `sigla`.
- `(idpozo, anio, mes)` has **0 duplicates**.
- `tipo_de_recurso` has one value (`NO CONVENCIONAL`): this file is all
  non-conventional.
- `formacion`: 27 lowercase values. "vaca muerta" 226,814 rows, equal to the
  count of `formprod` = `VMUT`. Others: lajas 78,981, mulichinco 35,526, los
  molles 28,658, quintuco 11,196.
- `sub_tipo_recurso`: SHALE 234,722, TIGHT 201,122, empty 464. SHALE is **not**
  the same as Vaca Muerta (234,722 vs 226,814).
- Basin: Neuquina 418,627, Austral 16,824, Golfo San Jorge 672, Noroeste 185.
  Province: Neuquén 385,453, Río Negro 29,932 (written `Rio Negro`), Santa Cruz
  17,219, Mendoza 3,242.
- `tipopozo`: gas wells 234,637 rows, oil wells 170,918.
- Mostly empty: `vida_util` (427,026), `observaciones` (411,363).

**First-production list ("Padrón").** 86,386 rows with three columns:
`idpozo, anio, mes`. Its ids cover 99.99% of the registry.

**Fracturing.** 5,064 rows, 30 columns, 4,820 `idpozo`: **one row per operation,
not per well**; 76 rows share (`idpozo`, `anio`, `mes`) with another row.
- Has: `longitud_rama_horizontal_m, cantidad_fracturas, tipo_terminacion,
  arena_bombeada_nacional_tn, arena_bombeada_importada_tn, agua_inyectada_m3,
  co2_inyectado_m3, presion_maxima_psi, potencia_equipos_fractura_hp`, and start
  and end dates.
- Does **not** have `duracion_fractura_dias` (derivable from the dates).
- Basins: Neuquina 4,261, Golfo San Jorge 589, Austral 214.
- Sample rows show `0` for lateral length and sand next to a non-zero stage
  count, which looks like placeholder zeros (rate not measured).

**Concessions.** 297 polygons, EPSG:4326, plausible bounds for Argentina. Nine
attributes: name, code, operator (`EMPRESA_OP`), `EMPRESA_IN`, participation (with
HTML tags in the text), comment, geometry as text, creation and modification
dates. **No Vaca Muerta or unconventional flag.** The comment field says some
geometries are provisional (a sample row says so).

## Joins (verified overlaps)
| From → to (on `idpozo`) | Found |
|---|---|
| Fracturing → registry | 4,813 of 4,820 (99.85%) |
| Production → registry | 5,164 of 5,214 (99.04%) |
| First-production list → registry | 85,847 of 86,386 (99.38%) |
| Fracturing → production | 4,024 of 4,820 (83.49%) |
| Production → fracturing | 4,024 of 5,214 (77.18%) |

So `idpozo` is a **shared key** across all four tables. About 23% of
unconventional production ids have no fracturing record. Wells → concessions: no
key is verified (see the open list).

## Coordinates: a data problem (verified symptom, inferred cause)
The shapefile's bounding box is `x` from -72.11 to **-38.59**, `y` from
**-69.42** to -22.00. Argentine longitudes do not reach -38, and no well has a
latitude of -69. The production file has the same two extremes. Inferred cause:
some wells have **latitude and longitude swapped**. How many is unknown.

## The first-production list is cut off at 2006 (verified on 3 wells)
The first three wells have drilling dates in 1996 and 1997 in the registry, but
`2006-01` in the list. The Capítulo IV data starts in 2006, so older wells show
the start of the dataset, not their real first month. The share of affected
wells is not measured.

## Research claims against the files
| Claim | Verdict |
|---|---|
| Production has 40 columns | **Confirmed**, all expected columns present |
| Production key (`idpozo`, `anio`, `mes`) | **Confirmed**: 0 duplicates |
| Shapefile is EPSG:4326 | **Confirmed** |
| Registry has 5 columns (`formprod`, `coordenadax`, `coordenaday`) | **Contradicted**: 26 columns, none of those three |
| `coordenadax` labeled latitude | Not applicable to the registry; see the coordinates section |
| `idpozo` is not one id per physical well | **Consistent** (85,858 ids vs 78,592 `sigla`), not proven |
| Fracturing is one row per operation | **Confirmed** |
| Fracturing has the six feature columns | **5 of 6**: `duracion_fractura_dias` missing |
| SHALE is not the same as Vaca Muerta | **Confirmed** |
| Concessions have no Vaca Muerta flag | **Confirmed** for this layer |
| License CC-BY 4.0 | **Contradicted** by the official field |

## Still unverified (next run)
- The latest month in the production and fracturing files, and rows per year.
- Units of `prod_pet`, `prod_gas`, `prod_agua` (the research says m³; not
  confirmed).
- How many points have swapped coordinates, and a rule to fix them.
- How often the fracturing columns are `0`.
- Whether the repeated `sigla` values differ by formation.
- The 12 less common `formacion` values, for spelling variants.
- What `rectificado` and `habilitado` mean in practice.
- Whether concession codes match `cod_area` or `idareapermisoconcesion`.
- The wells-listing, lots and permits files (not uploaded).
- Whether the file host answers from other clouds (GitHub, Render).

## Open decisions
- Does PetrIA treat **Quintuco** (11,196 production rows, a separate label) as
  part of Vaca Muerta? Default until decided: only `formacion` = `vaca muerta`.
- The data model for wells: one table by `idpozo`, or a well table by `sigla`
  plus a well-and-formation table.
