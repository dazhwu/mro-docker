#!/usr/bin/env R

pkgs <- read.csv('rpkgs.csv', header=TRUE);
pkgvec <- as.vector(pkgs$Package);
install.packages(c(pkgvec, 'blogdown', 'bookdown', 'pkgdown', 'radix'));
blogdown::install_hugo()
