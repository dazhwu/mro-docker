# A Docker image for Microsoft R Open

[![](https://images.microbadger.com/badges/image/blueogive/mro-docker.svg)](https://microbadger.com/images/blueogive/mro-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/blueogive/mro-docker.svg)](https://microbadger.com/images/blueogive/mro-docker "Get your own version badge on microbadger.com")

Microsoft R Open, formerly known as Revolution R Open, is an "enhanced R distribution".
You can use this Docker container to give MRO a quick try, i.e. without any impact on your local system, or to run MRO in an online Docker infrastructure.

Homepage: https://mran.microsoft.com/open

For plain R Docker images see [Rocker](https://github.com/rocker-org/rocker). The Rocker images were a great help in creating the MRO images.

> _MRO focuses on speed and reproducibility._

By default, packages are not installed from main CRAN, but from a CRAN repository snapshot.
For more information see https://mran.microsoft.com/documents/rro/reproducibility.
MRO promises better speed by using special multi-threaded math libraries, replacing default R's BLAS/LAPACK libraries.

**Important**: By running this container you accept the MKL and MRO licenses.

Image metadata can be explored at Microbadger: [https://microbadger.com/images/blueogive/mro-docker](https://microbadger.com/images/blueogive/mro-docker)

## Run container

```bash
docker run --user docker blueogive/mro-docker:latest
```

This downloads the latest build of the image from [Docker Hub](https://hub.docker.com/r/blueogive/mro-docker/).

Optionally you can use [tags](https://hub.docker.com/r/blueogive/mro-docker/tags/) for specific versions of MRO and execute a demo script:

```bash
docker run -it --rm blueogive/mro-docker:v3.5.3
```

Once the container starts, you will be at a bash prompt inside it. To run the `demo.R`
script, which executes some benchmarking code, you do this:

```bash
R
source("demo.R")
```
or this:

```bash
Rscript demo.R
```

To exit the running container, return to the `bash` prompt and type:

```bash
exit
```

To get exit an interactive `R` session and return tot he `bash` prompt, type:
```R
q()
```

To work with your own data, simply mount a directory on the host computer to the container, see the [Docker documentation on volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/):

```bash
docker run -it --rm -v path/to/my/data:/home/docker/work/data -v /path/to/my/source_code:/home/docker/work blueogive/mro-docker:v3.5.3
```

You can install packages etc. in the R session as usual, though for reproducibility it is strongly recommended to do this _only_ in the Dockerfile.

## 3.5.3

> _Microsoft R Open 3.5.3 is based on R-3.5.3._
> _The default CRAN mirror has been updated to point to the fixed CRAN repository snapshot from April 15, 2019._ [release notes](https://mran.microsoft.com/news#mro353)

The base image is Ubuntu 18.04.
See also [MRO 3.5.3 documentation](https://mran.microsoft.com/releases/3.5.3).
The v3.5.3 image is similar to the v3.5.2 and v3.5.1 images.

```bash
cd 3.5.3
docker build -t mro-docker:3.5.3 .
```

Alternatively, you can build the image using GNU Make:

```bash
make build-3.5.3
```

## 3.5.2

> _Microsoft R Open 3.5.2 is based on R-3.5.2._
> _The default CRAN mirror has been updated to point to the fixed CRAN repository snapshot from February 01, 2019._ [release notes](https://mran.microsoft.com/news#mro352)

The base image is Ubuntu 18.04.
See also [MRO 3.5.2 documentation](https://mran.microsoft.com/releases/3.5.2).
The v3.5.2 image is similar to the v3.5.1 image but is otherwise more elaborate
than the others in this repository:

1. The Ubuntu Linux OS layers include many of the develop libraries and header
files that many popular R packages depend upon (e.g., geos, gdal, curl, xml2,
cairo). This should make it easier successfully install a greater number of
R packages from within the running image;
1. The image includes a selection of [R packages](3.5.2/rpkgs.csv) that are widely
used including `ggplot2`, `tidyverse`, `data.table`, `rmarkdown`, and `bookdown`;
1. The `pacman` package is included to allow users to load or install and load
packages; and the `radix` package (since renamed `distill`) for authoring
scientific documents in Markdown; and
2. The [Hugo](https://gohugo.io/) static site generator is also installed and ready to use.

```bash
cd 3.5.2
docker build -t mro-docker:3.5.2 .
```

Alternatively, you can build the image using GNU Make:

```bash
make build-3.5.2
```

## 3.5.1

> _Microsoft R Open 3.5.1 is based on R-3.5.1._
> _The default CRAN mirror has been updated to point to the fixed CRAN repository snapshot from August 01, 2018._ [release notes](https://mran.microsoft.com/news#mro351)

The base image is Ubuntu 18.04.
See also [MRO 3.5.1 documentation](https://mran.microsoft.com/releases/3.5.1).
The v3.5.1 image is a bit more elaborate than the others in this repository in
two main ways:
1. The Ubuntu Linux OS layers include many of the develop libraries and header
files that many popular R packages depend upon (e.g., geos, gdal, curl, xml2,
cairo). This should make it easier successfully install a greater number of
R packages from within the running image; and
1. The image includes a selection of [R packages](3.5.1/rpkgs.csv) that are widely
used including `ggplot2`, `tidyverse`, `data.table`, `rmarkdown`, and `bookdown`.
The [Hugo](https://gohugo.io/) static site generator is also installed and ready to use.

```bash
cd 3.5.1
docker build -t mro-docker:3.5.1 .
```

Alternatively, you can build the image using GNU Make:

```bash
make build-3.5.1
```

## 3.5.0

> _Microsoft R Open 3.5.0 is based on R-3.5.0._
> _The default CRAN mirror has been updated to point to the fixed CRAN repository snapshot from June 01, 2018._ [release notes](https://mran.microsoft.com/news#mro350)

The base image is Ubuntu 16.04.
See also [MRO 3.5.0 documentation](https://mran.microsoft.com/releases/3.5.0).

```bash
cd 3.5.0
docker build -t mro:3.5.0 .
```

## 3.4.4

> _The CRAN repository points to a snapshot from May 1, 2017._
> _This means that every user of Microsoft R Open has access to the same set of CRAN package versions._ [source](https://mran.microsoft.com/documents/rro/installation/#revorinst-lin)

The base image is Ubuntu 16.04.
See also [MRO 3.4.4 documentation](https://mran.microsoft.com/releases/3.4.4).

Build the image:

```bash
cd 3.4.4
docker build -t mro:3.4.4 .
```

## 3.2.5

See installation instructions: https://mran.microsoft.com/archives/install-doc/mro-3.2.5/
The base image is Ubuntu 14.04.
The interactive installation script of the MKL download package was adapted in the file `RevoMath_noninteractive-install.sh` to not require any user input.
See also [MRO 3.2.5 documentation](https://mran.microsoft.com/archives/mro-3.2.5) (archived).

Build the image:

```bash
cd 3.2.5
docker build -t mro:3.2.5 .
```

## Automatic builds

The automatic builds are configured to run on the `master` branch and each Dockerfile, e.g. `/3.4.0/Dockerfile` is tagged with the full release version, e.g. `3.4.0`. Other semantic version tags are added automatically by build hooks based on the directory names, e.g. `latest`, `3`, and `3.4` for our example.

## License

[MRO and MKL licenses](https://mran.microsoft.com/faq/#licensing)

The following license applies to the code files in this repository:

Copyright (C) 2017 Daniel Nüst

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
