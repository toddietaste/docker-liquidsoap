FROM debian:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install liquidsoap liquidsoap-plugin-lame sudo && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/srv/liquidsoap"]
RUN mkdir /srv/liquidsoap
RUN chown -R liquidsoap:liquidsoap /srv/liquidsoap

USER liquidsoap
ENTRYPOINT ["liquidsoap", "/srv/liquidsoap/radio.liq", "--verbose"]
