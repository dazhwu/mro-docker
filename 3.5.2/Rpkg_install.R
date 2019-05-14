#!/usr/bin/env R

checkpoint::checkpoint('2019-05-01')
pkgs <- read.csv('rpkgs.csv', header=TRUE);
pkgvec <- as.vector(pkgs$Package);
install.packages(c(pkgvec));
options(blogdown.hugo.dir = '/usr/local/bin/')
blogdown::install_hugo()
tinytex::install_tinytex()
