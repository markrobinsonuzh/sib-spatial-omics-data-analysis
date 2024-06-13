# PASTA: Pattern Analysis for Spatial Omics Data

This repository contains scripts and vignettes for the [SIB days](https://sibdays.sib.swiss/tutorials-and-workshops) workshop "PASTA: Pattern Analysis for Spatial Omics Data".

## General Information and Agenda

In this workshop we will highlight the usefulness and transferability of existing spatial statistics approaches in the context of spatial tissue profiling. Primarily we will discuss point pattern and lattice data analysis using two spatial transcriptomics datasets.

Planned timeline:
| | |
|--|--|
| 09:30 - 10:00 | Introduction to spatial omics technologies and `PASTA` |
| 10:00 - 10:45 | Primer into point pattern analysis|
| 10:45 - 11:15 | Coffee break |
| 11:15 - 12:00 | Primer into lattice data analysis |
| 12:00 - 12:30 | Comparison of approaches; discussion |


In the point pattern and lattice analysis part, you will go through a quarto document that you find in `????`. You will need to have a number of packages installed to run the quarto documents. Please read the instructions for installation below.

## Necessary software / environment

Please bring your personal laptop with an installation of `R`. The `R` version must be 4.2 or higher. Electrical outlets will be available in the room.

To install all necessary packages please run the following commands in `R`.

```
pkgs <- c("????", "?????")

install.packages("BiocManager")
BiocManager::install(pkgs)
```

## Organizers
- Martin Emons, PhD Student, Statistical Bioinformatics Group, University of Zurich
- Samuel Gunz, PhD Student, Statistical Bioinformatics Group, University of Zurich
- Mark D. Robinson, Professor of Statistical Genomics, University of Zurich
- Helena L. Crowell, Postdoc, CNAG
