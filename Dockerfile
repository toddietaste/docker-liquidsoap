FROM ubuntu:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install liquidsoap liquidsoap-plugin-all && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/home/liquidsoap"]

#USER liquidsoap
#CMD ["liquidsoap", "/home/liquidsoap/radio.liq", "--verbose"]
