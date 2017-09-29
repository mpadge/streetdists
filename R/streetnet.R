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

    hard_cities <- c ("bo")
    easy_cities <- cities [which (!cities %in% hard_cities)]
    if (city %in% easy_cities)
    {

        dat <- osmdata::opq (bbox, timeout = 1000,
                    memsize = 1073741824) %>%
            osmdata::add_osm_feature (key = "highway") %>%
            osmdata::osmdata_sf (quiet = FALSE)
        dat <- dat$osm_lines
    } else if (city == "bo")
    {
        # residential first because it's the largest and most likely to fail
        vals <- c ("residential", "primary", "secondary", "tertiary",
                   "unclassified", "path", "motorway")
        nets <- list ()
        for (v in vals)
        {
            message ("---Extracting ", v, " highways")
            qry <- opq (bbox, timeout = 1000, memsize = 1073741824) %>%
                add_osm_feature (key = "highway", value = v)
            nets <- c (nets, osmdata_sf (qry, quiet = FALSE)$osm_lines)
        }

        # Then all the rest:
        qry <- opq (bbox, timeout=1000, memsize = 1073741824)
        for (v in vals)
            qry <- add_osm_feature (qry, key = "highway",
                                    value = paste0 ("!", v))
        nets <- c (nets, osmdata_sf (qry, quiet = FALSE)$osm_lines)

        dat <- nets [[1]]
        nets [[1]] <- NULL
        for (n in nets)
            dat <- c (dat, n)
    }
    return (dat)
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
