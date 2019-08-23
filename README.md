# An interdisciplinary evaluation of community-based TURF-reserves

This repository contains the data and code for:
  
Villaseñor-Derbez JC, Aceves-Bueno E, Fulton S, Suarez A, Hernández-Velasco A, Torre J, et al. (2019) An interdisciplinary evaluation of community-based TURF-reserves. PLoS ONE 14(8): e0221660. https://doi.org/10.1371/journal.pone.0221660


## Contents

The repository contains five key directories:
  
- `raw_data`: Contains the original, raw data from COBI monitorign program or spatial information for maps and TURFs. These data have not been manipulated directly by us.
- `data`: The data folder contains transformed and processed data.
- `scripts`: This folder contains processing and analysis scripts. Essentially, a processing script reads data from `raw_data`, does something to it, and exports it to `data`. (For example [data_cleaning_logbook.Rmd](/scripts/processing/data_cleaning_logbook.Rmd)).
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
   |__img
   |__plos-one.csl
   |__PLOS-submission-eps-converted-to.pdf
   |__PLOS-submission.eps
   |__plos.csl
   |__PLoS.ens
   |__PLoS_manuscript.bbl
   |__PLoS_manuscript.log
   |__PLoS_manuscript.pdf
   |__PLoS_manuscript.synctex.gz
   |__PLoS_manuscript.tex
   |__PLoS_manuscript_diff.pdf
   |__PLoS_manuscript_diff.synctex.gz
   |__PLoS_manuscript_diff.tex
   |__plos2015.bst
   |__references.bib
   |__supplementary.pdf
   |__supplementary.synctex.gz
   |__supplementary.tex
   |__tab
-- figures
   |__bio_results.png
   |__map.png
   |__pbc.png
   |__ph.png
   |__soc_results.png
-- raw_data
   |__conapesca.rds
   |__conapesca_2000-2015.RData
   |__CPI.csv
   |__fish_data.csv
   |__invert_data.csv
   |__SES.csv
   |__spatial
-- scripts
   |__content
   |__functions
   |__processing
```

--------- 

<a href="https://orcid.org/0000-0003-1245-589X" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon">orcid.org/0000-0003-1245-589X</a>
