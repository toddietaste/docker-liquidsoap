FROM alpine:edge

MAINTAINER infiniteproject@gmail.com

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update ocaml@testing opam@testing && \
    opam init && opam install depext && opam depext liquidsoap && opam install liquidsoap

#RUN adduser liquidsoap && mkdir -p /srv/liquidsoap && chown -R liquidsoap:liquidsoap /srv/liquidsoap
#USER liquidsoap
#RUN git clone https://github.com/savonet/liquidsoap-full.git liquidsoap && \
#    cd liquidsoap && make init && ./bootstrap && ./configure && \
#    cp PACKAGES.minimal PACKAGES && make

#ENTRYPOINT ["liquidsoap", "/srv/liquidsoap/radio.liq"]
