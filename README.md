# Effectiveness of community-based TURF-reserves in Mexican small-scale fisheries

This repository contains the data and code for:

Villaseñor-Derbez, J.C., Aceves-Bueno E., Fulton, S., Suarez-Castillo, A., HernándezVelasco, A., Torre, J., Micheli, F. (in review). Effectiveness of community-based TURF-reserves in Mexican small-scale fisheries.

The packrat folder should include all the relevant R packages to reproduce the analyses and results presented in this paper. The manuscript, written in Rmd, can be found under the docs/ folder.

## Contents

The repository contains five key directories:
  
- `raw_data`: Contains the original, raw data from COBI monitorign program or spatial information for maps and TURFs. These data have not been manipulated directly by us.
- `data`: The data folder contains transformed and processed data.
- `scripts`: This folder contains processing and analysis scripts. Essentially, a processing script reads data from `raw_data`, does something to it, and exports it to `data`. (For example [data_cleaning_logbook.Rmd](/scripts/data_cleaning_logbook.Rmd)).
- `docs`: Contains the `*.Rmd`, `*.tex` files, bibliography, and `*.pdf` of the manuscript.

## Repository structure 

```
-- data
   |__conapesca.csv
   |__fish.csv
   |__gov_ind.csv
   |__gov_res.csv
   |__governance.csv
   |__governance_summary.csv
   |__invertebrates.csv
   |__results
-- docs
   |__FMS_templates
   |__frontiers_suppmat.cls
   |__frontiersinSCNS_ENG_HUMS.bst
   |__frontiersSCNS.cls
   |__header.tex
   |__logo1.jpg
   |__manuscript.pdf
   |__manuscript.Rmd
   |__manuscript.tex
   |__manuscript_diff.bbl
   |__manuscript_diff.log
   |__manuscript_diff.pdf
   |__manuscript_diff.synctex.gz
   |__manuscript_diff.tex
   |__manuscript_files
   |__references.bib
   |__reviewer_comments.pdf
   |__reviewer_comments.Rmd
   |__SupplementaryMaterial.pdf
   |__SupplementaryMaterial.Rmd
   |__SupplementaryMaterial.tex
   |__SupplementaryMaterial_files
   |__technical_report
   |__template.tex
   |__template_sup.synctex.gz
   |__template_sup.tex
   |__WSSFConf_abstract
-- figures
   |__bio_results.png
   |__map.png
   |__pbc.png
   |__ph.png
   |__soc_results.png
-- packrat
   |__lib
   |__lib-ext
   |__lib-R
   |__packrat.lock
   |__packrat.opts
   |__src
-- raw_data
   |__conapesca.rds
   |__conapesca_2000-2015.RData
   |__CPI.csv
   |__fish_complete.csv
   |__fish_data.csv
   |__invert_complete.csv
   |__invert_data.csv
   |__SES.csv
   |__spatial
-- README.md
-- ReserveEffect.Rproj
-- scripts
   |__abundance.R
   |__analisis.R
   |__biomass.R
   |__create_turf_shapefile.R
   |__data_cleaning_logbook.html
   |__data_cleaning_logbook.Rmd
   |__extract_effect.R
   |__map_for_poster.R
   |__model.R
   |__modelo.R
   |__my_ggplot.R
   |__my_plot.R
   |__plot_model.R
   |__plot_socioeco.R
   |__robust_se.R
   |__robust_se_list.R
   |__trophic.R
-- slides
   |__GainesLabPresentation.html
   |__GainesLabPresentation.Rmd
   |__GainesLabPresentation_files
   |__img
   |__libs
```

--------- 

<a href="https://orcid.org/0000-0003-1245-589X" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon">orcid.org/0000-0003-1245-589X</a>
