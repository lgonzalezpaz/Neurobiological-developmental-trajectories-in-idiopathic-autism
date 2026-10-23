#!/usr/bin/env bash
# Reproduce every number, table and figure in the manuscript.
# Total runtime on a 2-core laptop: about 1.5-2 h (ABC calibration and power grid dominate).
set -euo pipefail
cd "$(dirname "$0")"
[ -f data/raw/brainspan/expression_matrix.csv ] || bash src/00_download_data.sh
cd src
python 01_brainspan_trajectories.py      # normative trajectories (Fig. 2)
python 02_postmortem_cohorts.py          # harmonised module scores
python 03_postmortem_stats.py            # meta-analysis, coupling, heterogeneity (Fig. 3)
python 05_genetic_entry_points.py        # SFARI x GO enrichment (Fig. 3e)
python 04_calibrate_model.py             # ABC calibration + lesion fitting (Figs 1, 4)
python 07_sensitivity_bistability.py     # Sobol + fixed points (Fig. 4)
python 06_insilico_trial.py all          # in-silico longitudinal trial (Fig. 5)
python 08_prediction_trial.py            # multicentre prediction + treatment allocation (Fig. 7)
python fig_realdata.py
python fig_model.py fig1 fig4 fig5 fig6 fig7
python make_tables.py
node ../docs/build_docx.js               # Word manuscript (requires Node.js + docx)
echo "All outputs written to results/ and figures/."
