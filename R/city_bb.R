#' city_bb
#'
#' Return the bounding box of bicycle stations from one city
#'
#' @param city (in standard two-letter \code{bikedat} form: "lo", "ny", "bo",
#' "ch", "dc", or "la").
#' @param expand Relative factor by which to expand the bbox
#' @return Numeric vector of four values defining the bounding box
#' @export
city_bb <- function (city, expand = 0)
{
    cities <- c ("bo", "ch", "dc", "la", "lo", "ny", "ph")

    if (!city %in% cities)
        stop (paste ("city must be one of [", cities, "]"))

    bb <- list ()
    bb [[1]] <- rbind (c (-73.56692, -71.00621),
                       c (42.30347,  45.50509))
    bb [[2]] <- rbind (c (-87.80287, -87.54939),
                       c (41.73665,  42.06400))
    bb [[3]] <- rbind (c (-77.36842, -76.91356),
                       c (38.79756,  39.12351))
    bb [[4]] <- rbind (c (-118.47283, -118.23128),
                       c (33.98738,   34.06428))
    bb [[5]] <- rbind (c (-0.236769, -0.100168),
                       c (51.454752, 51.542138))
    bb [[6]] <- rbind (c (-74.09694, -73.92850),
                       c (40.64654,  40.80421))
    bb [[7]] <- rbind (c (-75.22399, -75.12996),
                       c (39.92777,  39.99179))
    names (bb) <- cities # redundant

    bb <- bb [[which (cities == city)]]
    bb [1, ] <- bb [1, ] + c (-expand, expand) * diff (bb [1, ])
    bb [2, ] <- bb [2, ] + c (-expand, expand) * diff (bb [2, ])

    return (bb)
}