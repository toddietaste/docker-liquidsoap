FROM ocaml/opam2:ubuntu

MAINTAINER Ryan Foster <phasecorex@gmail.com>

ENV PACKAGES "taglib mad lame vorbis cry opus fdkaac faad liquidsoap"

RUN opam depext -i $PACKAGES

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
