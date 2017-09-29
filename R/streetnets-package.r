#' streetnets.
#'
#' Extract OSM street networks for bikedata cities
#'
#' The \code{bikedata} cities currently include
#' \itemize{
#' \item Santander Cycles London, U.K.
#' \item citibike New York City NY, U.S.A.
#' \item Divvy Chicago IL, U.S.A.
#' \item Capital BikeShare Washingon DC, U.S.A.
#' \item Hubway Boston MA, U.S.A.
#' \item Metro Los Angeles CA, U.S.A.
#' \item Indego Philadephia PA, U.S.A.
#' }
#'
#' @name streetnet
#' @docType package
#' @author Mark Padgham
#' @importFrom dodgr weight_streetnet
#' @importFrom magrittr %>%
#' @importFrom osmdata add_osm_feature opq osmdata_sf
NULL
