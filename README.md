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
pkgs <- c('SpatialExperiment', 'spatstat.geom', 'spatstat.explore', 
'dplyr', 'ggplot2', 'patchwork', 'reshape2', 'Voyager', 
'SpatialFeatureExperiment', 'SFEData', 'spdep', 'sf', 'stringr', 'tidyr',
'magrittr','scater')

install.packages("BiocManager")
BiocManager::install(pkgs)
```

### Docker

In case there are problems installing the software, another option is to use an already-prepared [Docker](https://www.docker.com/) container. This would require you to install Docker on your computer; see [here](https://www.docker.com/products/docker-desktop/). For Apple M1 useres: You need to enable the rosetta 2 virtualization feature in docker desktop. To use the docker container, you can download the prepared image and run it as follows:

```
docker pull markrobinsonuzh/sibdays-pasta:14062024
docker run -e PASSWORD=abc -p 8787:8787 markrobinsonuzh/sibdays-pasta:14062024
```

Once that is running, go to a web browser and use `localhost:8787` to bring up an RStudio instance that is running within the Docker container (username is `rstudio`, password is as set in the command above). All the software needed for the PASTA workshop is already installed there.

## Organizers
- Martin Emons, PhD Student, Statistical Bioinformatics Group, University of Zurich
- Samuel Gunz, PhD Student, Statistical Bioinformatics Group, University of Zurich
- Mark D. Robinson, Professor of Statistical Genomics, University of Zurich
- Helena L. Crowell, Postdoc, CNAG
