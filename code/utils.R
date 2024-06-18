suppressPackageStartupMessages({
  library(SpatialExperiment)
  library(spatstat.geom)
  library(spatstat.explore)
  library(dplyr)
  library(ggplot2)
  library(patchwork)
  library(reshape2)
  library(Voyager)
  library(SpatialFeatureExperiment)
  library(SFEData)
  library(spdep)
  library(sf)
  library(stringr)
  library(tidyr)
  library(magrittr)
})

#' Convert SpatialExperiment object to ppp object
#'
#' @param spe a spatial experiment objects
#' @param marks the marks to attribute
#'
#' @return a point pattern object
#' @export
#'
#' @examples
.ppp <- \(spe, marks = NULL) {
  xy <- spatialCoords(spe)
  w <- owin(range(xy[, 1]), range(xy[, 2]))
  m <- if (is.character(marks)) {
    stopifnot(
      length(marks) == 1,
      marks %in% c(
        gs <- rownames(spe),
        cd <- names(colData(spe))))
    if (marks %in% gs) {
      assay(spe)[marks, ]
    } else if (marks %in% cd) {
      spe[[marks]]
    } else stop("'marks' should be in ",
      "'rownames(.)' or 'names(colData(.))'")
  }
  ppp(xy[, 1], xy[, 2], window = w, marks = factor(m))
}

#' Calculate a spatstat metric
#'
#' @param fun which function to calculate
#' @param pp_ls a list of point pattern objects
#' @param by which objects to compare, e.g. a list of the z-stacks
#' @param mark which mark (e.g. celltype(s)) to compute the metric on
#' @param continuous whether or not the mark is continous
#'
#' @return a dataframe with the radius and the results at which they were
#'         calculated
#' @export
#'
#' @examples
calcMetric <- function(fun, pp_ls, by, mark, continuous = FALSE) {
  res_df <- lapply(by, function(x) {
    if (continuous) {
      pp_sub <- subset(pp_ls[[x]], select = mark)
    } else {
      pp_sub <- subset(pp_ls[[x]], 
                       marks %in% mark, drop = TRUE)
    }
    
    res <- do.call(fun, args = list(X = pp_sub))
    res$stack <- x
    return(res)
  }) %>% bind_rows()
  return(res_df)
}
