FROM rhub/r-minimal

RUN installr -d -t "openssl-dev curl-dev" -a "openssl" gh remotes

COPY . /pkg
COPY entrypoint.sh /entrypoint.sh

RUN R -e 'remotes::install_local("/pkg")'

ENTRYPOINT ["sh","/entrypoint.sh"]
