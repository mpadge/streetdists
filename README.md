<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/mpadge/streetnets.svg)](https://travis-ci.org/mpadge/streetnets) [![Project Status: Active](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

streetnets
==========

Extract OpenStreetMap street networks using the [`osmdata` package](https://github.com/ropensci/osmdata) for cities represented in the [`bikedata` package](https://github.com/ropensci/bikedata).

Installation
------------

You can install streetnets from github with:

``` r
# install.packages("devtools")
devtools::install_github("mpadge/streetnets")
```

Usage
-----

Extract a single street network for London, New York, Chicago, Philadelphia, Washington DC, Boston, or Los Angeles (respectively "ny", "ch", "ph", "dc", "bo", and "la") like this:

``` r
net <- get_streetnet ("ny")
```

Or save all to disk with

``` r
get_all_networks ()
```

Street networks are returned as simple `data.frame` objects of a form ready to submit to [`dodgr`](https://github.com/gmost/dodgr) routines for calculating distances. See the [`dodgr` vignette](https://gmost.github.io/dodgr/articles/dodgr.html) for more information.
