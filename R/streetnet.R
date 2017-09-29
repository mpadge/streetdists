#' get_streetnet
#'
#' Get the street network for a particular city
#'
#' @param city (in standard two-letter \code{bikedat} form: "lo", "ny", "bo",
#' "ch", "dc", or "la").
#' @return \code{sf data.frame} of the street network.
#'
#' @note The problematic cities like Boston probably need sf to be loaded into
#' the workspace to work properly?
#'
#' @export
get_streetnet <- function (city)
{
    cities <- c ("bo", "ch", "dc", "la", "lo", "ny", "ph")
    if (!city %in% cities)
        stop (paste ("city must be one of [", cities, "]"))

    bbox <- city_bb (city)

    dat <- osmdata::opq (bbox, timeout = 1000,
                         memsize = 1073741824) %>%
            osmdata::add_osm_feature (key = "highway") %>%
            osmdata::osmdata_sf (quiet = FALSE)

    return (dat$osm_lines)
}

#' get_all_networks
#'
#' Extract street networks for all \code{bikedata} cities, and save each one in
#' a \code{streetnet_XX.rda} file.
#'
#' @return Nothing (data are written to disk).
#' @export
get_all_networks <- function ()
{
    cities <- c ("bo", "ch", "dc", "la", "lo", "ny", "ph")
    streetnets <- list ()
    for (ci in cities)
    {
        net <- get_streetnet (ci)
        nm <- paste0 ("net_", ci)
        assign (nm, net)
        save (list = nm, file = paste0 (nm, ".rda"))
    }
}
