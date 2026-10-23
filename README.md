# Pruning–splicing reciprocity (PSR) model of idiopathic autism

Code and derived data for the manuscript

> **Where does the loop begin? A calibrated pruning–splicing model and in-silico trial specify the longitudinal design needed to stratify idiopathic autism.** [AUTHOR], [YEAR]. [JOURNAL / preprint DOI]

The repository reproduces every number, table and figure in the manuscript from public raw data, on a standard laptop (2 cores, 8 GB RAM, ~1.5–2 h end to end).

## What the code does

| Step | Script | Output | Manuscript |
|---|---|---|---|
| 0 | `src/00_download_data.sh` | public raw data in `data/raw/` | Table 2 |
| 1 | `src/01_brainspan_trajectories.py` | normative module trajectories, timing statistics | Fig. 2 |
| 2 | `src/02_postmortem_cohorts.py` | harmonized module scores for GSE28521, GSE28475, GSE102741 | — |
| 3 | `src/03_postmortem_stats.py` | random-effects meta-analysis, coupling, dispersion, mixture, age interaction | Fig. 3a–d, Suppl. Table 1 |
| 4 | `src/05_genetic_entry_points.py` | SFARI × GO enrichment | Fig. 3e, Suppl. Table 2 |
| 5 | `src/04_calibrate_model.py` | ABC calibration (60,000 prior draws), lesion fitting, held-out predictions | Fig. 1, Tables 2 and 3 |
| 6 | `src/07_sensitivity_bistability.py` | Sobol indices, adult fixed points | Fig. 4d,e |
| 7 | `src/06_insilico_trial.py` | in-silico longitudinal trial, RI-CLPM vs CLPM, power | Fig. 5, Table 4 |
| 7b | `src/08_prediction_trial.py` | six-site trial: individual outcome prediction (leave-sites-out), horizon, learning curve, route-stratified treatment allocation | Fig. 6, Table 4 |
| 8 | `src/fig_realdata.py`, `src/fig_model.py` | all figures (PNG 600 dpi, PDF and SVG vector) | Figs 1–7 |
| 9 | `src/make_tables.py` | tables as CSV | Tables 1–4 |
| 10 | `docs/build_docx.js` | Word manuscript with editable equations | — |

Core modules: `src/model.py` (PSR model, vectorized RK4 and stochastic integrators), `src/riclpm.py` (maximum-likelihood RI-CLPM/CLPM), `src/config.py` (paths, a-priori gene modules, plotting style).

## Quick start

```bash
git clone [GITHUB URL] psr-autism && cd psr-autism
conda env create -f environment.yml && conda activate psr-autism   # or: pip install -r requirements.txt
bash run_all.sh
```

To rebuild only the Word manuscript (requires Node.js with the `docx` package):

```bash
python docs/manuscript_content.py && node docs/build_docx.js
```

## Input data

All inputs are public and downloaded by `src/00_download_data.sh`. Raw files are not redistributed here; their SHA-256 checksums (downloaded 2026-10-20) are in `data/raw/SHA256SUMS.txt`.

| Resource | Accession / URL | Use |
|---|---|---|
| BrainSpan developmental transcriptome (RNA-seq, gene RPKM) | brainspan.org, file 267666525 | normative trajectories |
| Voineagu et al. 2011 | GEO GSE28521 (GPL6883) | post-mortem cohort 1 |
| Chow et al. 2012 | GEO GSE28475 (GPL6883 frozen DASL subset) | post-mortem cohort 2 |
| Wright et al. 2017 | GEO GSE102741 | post-mortem cohort 3 (with age, sex, RIN) |
| SFARI Gene, human gene module | gene.sfari.org | genetic loading |
| GO Biological Process 2023 | Enrichr library | gene-set definitions, background |

SFARI Gene and the Enrichr library are updated over time; results were produced with the versions whose checksums are listed. Minor differences may arise with newer releases.

## Derived data included

- `data/processed/` — donor-level module scores, harmonized post-mortem scores, ABC prior samples, simulated cohort.
- `results/` — posterior parameter sets (`abc_posterior.csv`), all statistics as JSON/CSV, power and design grids, run logs.
- `figures/` — Figures 1–6 as PNG (600 dpi), PDF and SVG.
- `tables/` — Tables 1–4 and Supplementary Tables 1–2.
- `manuscript/` — the manuscript (.docx).

## Reproducibility notes

- Random seed: `20261020` (set in `src/config.py`).
- Exact package versions: `requirements.txt` (Python 3.13.16).
- Gene modules are fixed a priori in `src/config.py` and were not tuned on validation data.
- The RI-CLPM estimator is validated against data simulated from a known RI-CLPM (see Methods); unbiased recovery of cross-lagged effects at *n* = 5,000.

## Licence

Code: MIT (see `LICENSE`). Derived data, figures and tables: CC BY 4.0. Third-party raw data remain under their original terms.

## Citation

See `CITATION.cff`. Please also cite the original data resources listed above.
