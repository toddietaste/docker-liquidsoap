FROM ocaml/opam2:ubuntu-18.04-ocaml-4.07 as builder

ENV EXTRA_PACKAGES="taglib mad lame vorbis cry opus fdkaac faad flac"

RUN set -eux; \
    git pull; \
    opam update; \
    opam upgrade; \
    eval $(opam env); \
    sudo apt-get update; \
    opam depext -i $EXTRA_PACKAGES liquidsoap

RUN set -eux; \
    eval $(opam config env); \
    mkdir -p /home/opam/root; \
    mv $(which liquidsoap) /home/opam/root; \
    opam depext -ln $EXTRA_PACKAGES > /home/opam/root/depexts; \
    mkdir -p /home/opam/root/$OPAM_SWITCH_PREFIX/lib; \
    mv $OPAM_SWITCH_PREFIX/share /home/opam/root/$OPAM_SWITCH_PREFIX; \
    mv $OPAM_SWITCH_PREFIX/lib/liquidsoap /home/opam/root/$OPAM_SWITCH_PREFIX/lib



FROM phasecorex/user-ubuntu:18.04 as runner

COPY --from=builder /home/opam/root /

RUN set -eux; \
    apt-get update; \
    cat /depexts | xargs apt-get install -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    /liquidsoap --version

ENTRYPOINT ["user-entrypoint", "/liquidsoap"]

LABEL maintainer="Ryan Foster <phasecorex@gmail.com>"
