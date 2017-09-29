#' get_streetnet
#'
#' Get the street network for a particular city
#'
#' @param city (in standard two-letter \code{bikedat} form: "lo", "ny", "bo",
#' "ch", "dc", or "la").
#' @export
get_streetnet <- function (city)
{
    cities <- c ("bo", "ch", "dc", "la", "lo", "ny", "ph")
    if (!city %in% cities)
        stop (paste ("city must be one of [", cities, "]"))

    easy_cities <- c ("ch")
    if (city %in% easy_cities)
    {
        dat <- osmdata::opq (bbox) %>%
            osmdata::add_osm_feature (key = "highway") %>%
            osmdata::osmdata_sf (quiet = quiet)
    }
    return (dat)
}
