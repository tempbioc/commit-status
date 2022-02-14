FROM rhub/r-minimal

COPY . /pkg
COPY entrypoint.sh /entrypoint.sh

RUN installr -d -t "openssl-dev curl-dev" -a "openssl" local::/pkg

ENTRYPOINT ["sh","/entrypoint.sh"]
