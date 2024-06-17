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


#' Compute the relative risk of a point pattern
#'
#' @param pp a point pattern to compute
#' @param alpha significance level alpha
#'
#' @return a list with the relative risk results
#' @export
#'
#' @examples
pValuesHotspotMarks <- function(pp, alpha = 0.05){
  # Code source: https://idblr.rbind.io/post/pvalues-spatial-segregation/
  
  # Significant p-values assumming normality of the Poisson process
  ## relrisk() computes standard errors based on asymptotic theory, assuming a Poisson process
  # call relative risk function
  f1 <- relrisk(pp_sel,se=TRUE)
  
  z <- qnorm(alpha/2, lower.tail = F)     # z-statistic
  f1$u <- f1$estimate + z*f1$SE           # Upper CIs
  f1$l <- f1$estimate - z*f1$SE           # Lower CIs
  mu_0 <- as.vector(table(spatstat.geom::marks(pp))/pp$n) # null expectations by type
  f1$p <- f1$estimate # copy structure of pixels, replace values
  for (i in 1:length(f1$p)) {
    f1$p[[i]]$v <- factor(ifelse(mu_0[i] > f1$u[[i]]$v, "lower",
                                ifelse( mu_0[i] < f1$l[[i]]$v, "higher", "none")),
                          levels = c("lower", "none", "higher"))
  }
  return(f1)
}

#' Compute p-values of the hotspots
#'
#' @param pp a point pattern to compute
#' @param alpha significance level alpha
#'
#' @return a density estimate
#' @export
#'
#' @examples
pValuesHotspot <- function(pp, alpha = 0.05){
  # Code source: https://idblr.rbind.io/post/pvalues-spatial-segregation/
  # density estimate for all marks
  f1 <- density(unmark(pp), se = TRUE)
  # Significant p-values assumming normality of the Poisson process
  z <- qnorm(alpha/2, lower.tail = F)     # z-statistic
  f1$u <- f1$estimate + z*f1$SE           # Upper CIs
  f1$l <- f1$estimate - z*f1$SE           # Lower CIs
  mu_0 <- intensity(unmark(pp)) # null expectations by type
  f1$p <- f1$estimate # copy structure of pixels, replace values
  f1$p$v <- factor(ifelse(mu_0 > f1$u$v, "lower",
                          ifelse( mu_0 < f1$l$v, "higher", "none")),
                   levels = c("lower", "none", "higher"))
  
  return(f1)
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
