# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
FROM ubuntu:bionic-20190307

USER root

## Install some useful tools and dependencies for MRO
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		build-essential \
		fonts-texgyre \
		gfortran \
		git \
		gnupg2 \
		gosu \
		default-jdk \
		locales \
		make \
		curl \
		dpkg \
		pandoc \
		pandoc-citeproc \
		# Linux system packages that are dependencies of R packages
		libxml2-dev \
		libcurl4-gnutls-dev \
		liblapack-dev \
		libgdal-dev \
		libgeos-dev \
		libproj-dev \
		libcairo2-dev \
        libssl1.0-dev \
		unzip \
		wget \
		# Allow R pkgs requiring X11 to install/run using virtual framebuffer
		xvfb \
		xauth \
		xfonts-base \
		# MRO dependencies that don't sort themselves out on their own:
		less \
		libgomp1 \
		libpango-1.0-0 \
		libxt6 \
		libsm6 \
	&& apt-get clean

## Install Microsoft ODBC driver and SQL commandline tools
RUN curl -o microsoft.asc https://packages.microsoft.com/keys/microsoft.asc \
    && apt-key add microsoft.asc \
    && rm microsoft.asc \
    && curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends \
        msodbcsql17 \
        mssql-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Set environment variables
ENV LC_ALL=en_US.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
    PATH=/opt/mssql-tools/bin:${PATH} \
	MRO_VERSION_MAJOR=3 \
	MRO_VERSION_MINOR=5 \
	MRO_VERSION_BUGFIX=1 \
	SHELL=/bin/bash \
    CT_USER=docker \
    CT_UID=1000 \
    CT_GID=100 \
	CT_FMODE=0775 \
	FONT_LOCAL=/usr/local/share/fonts
ENV HOME=/home/${CT_USER}

COPY fonts.zip ${FONT_LOCAL}

WORKDIR ${FONT_LOCAL}

## Setup the locale
RUN unzip fonts.zip \
	&& rm fonts.zip \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8 \
	&& git clone --branch release --depth 1 \
	'https://github.com/adobe-fonts/source-code-pro.git' \
	"${FONT_LOCAL}/adobe-fonts/source-code-pro" \
	&& fc-cache -f -v "${FONT_LOCAL}"

## (Based on https://github.com/rocker-org/rocker/blob/master/r-base/Dockerfile)
## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (e.g. for linked volumes to work properly).
RUN useradd ${CT_USER} --uid ${CT_UID} --gid ${CT_GID} \
	&& mkdir --mode ${CT_FMODE} ${HOME} \
	&& chown ${CT_USER}:${CT_GID} ${HOME} \
	&& addgroup ${CT_USER} staff

ENV MRO_VERSION=${MRO_VERSION_MAJOR}.${MRO_VERSION_MINOR}.${MRO_VERSION_BUGFIX}

WORKDIR ${HOME}

## Download and install MRO & MKL
RUN curl -LO -# https://mran.blob.core.windows.net/install/mro/${MRO_VERSION}/microsoft-r-open-${MRO_VERSION}.tar.gz \
	&& tar -xzf microsoft-r-open-${MRO_VERSION}.tar.gz
WORKDIR ${HOME}/microsoft-r-open
RUN ./install.sh -a -u

# Clean up downloaded files and install libpng
WORKDIR ${HOME}
RUN rm microsoft-r-open-*.tar.gz && \
	rm -r microsoft-r-open && \
    curl -LO -# https://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && \
    dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb && \
    rm libpng12-0_1.2.54-1ubuntu1_amd64.deb

COPY Renviron.site Renviron.site
RUN mv Renviron.site /opt/microsoft/ropen/$MRO_VERSION/lib64/R/etc

COPY rpkgs.csv rpkgs.csv
COPY Rpkg_install.R Rpkg_install.R
RUN xvfb-run Rscript Rpkg_install.R && \
	rm rpkgs.csv Rpkg_install.R

USER ${CT_USER}
RUN mkdir -p --mode ${CT_FMODE} ${HOME}/work ${HOME}/R/lib
ENV R_LIBS_USER=${HOME}/R/lib
WORKDIR ${HOME}/work

# Add demo script
COPY demo.R demo.R

ARG VCS_URL=${VCS_URL}
ARG VCS_REF=${VCS_REF}
ARG BUILD_DATE=${BUILD_DATE}

# Add image metadata
LABEL org.label-schema.license="https://mran.microsoft.com/faq/#licensing" \
    org.label-schema.vendor="Microsoft Corporation, Dockerfile provided by Mark Coggeshall, forked from nuest/mro-docker" \
	org.label-schema.name="Microsoft R Open" \
	org.label-schema.description="Docker images of Microsoft R Open (MRO) with the Intel® Math Kernel Libraries (MKL)." \
	org.label-schema.vcs-url=${VCS_URL} \
	org.label-schema.vcs-ref=${VCS_REF} \
	org.label-schema.build-date=${BUILD_DATE} \
	maintainer="Mark Coggeshall <mark.coggeshall@gmail.com>"

USER root

ENTRYPOINT ["/bin/bash"]
