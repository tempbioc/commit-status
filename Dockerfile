FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:marutter/rrutter4.0 && \
  add-apt-repository -y "ppa:c2d4u.team/c2d4u4.0+" && \
  apt-get update && \
	apt-get install -y --no-install-recommends r-cran-gh r-cran-remotes

COPY . /pkg
COPY entrypoint.sh /entrypoint.sh

RUN \
	R -e 'remotes::install_local("/pkg")'

ENTRYPOINT ["/entrypoint.sh"]

