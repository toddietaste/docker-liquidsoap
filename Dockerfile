FROM ocaml:alpine

MAINTAINER infiniteproject@gmail.com

RUN apk add --update make perl git automake autoconf g++
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update ocaml

RUN adduser liquidsoap && mkdir -p /srv/liquidsoap && chown -R liquidsoap:liquidsoap /srv/liquidsoap
USER liquidsoap
RUN git clone https://github.com/savonet/liquidsoap-full.git liquidsoap && \
    cd liquidsoap && make init && ./bootstrap && ./configure && \
    cp PACKAGES.minimal PACKAGES && make

ENTRYPOINT ["liquidsoap", "/srv/liquidsoap/radio.liq"]
