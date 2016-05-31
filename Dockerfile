FROM debian:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install liquidsoap liquidsoap-plugin-all && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /srv/liquidsoap && chown -R liquidsoap:liquidsoap /srv/liquidsoap

USER liquidsoap
ENTRYPOINT ["liquidsoap", "/srv/liquidsoap/script.liq"]
