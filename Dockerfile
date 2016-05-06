FROM debian:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install liquidsoap liquidsoap-plugin-lame && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/srv/liquidsoap"]

#USER liquidsoap
#CMD ["liquidsoap", "/srv/liquidsoap/radio.liq", "--verbose"]
