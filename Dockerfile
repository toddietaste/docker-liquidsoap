FROM debian:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends liquidsoap liquidsoap-plugin-all && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/home/liquidsoap"]

USER liquidsoap
CMD ["liquidsoap", "$LS_SCRIPT", "--verbose"]
