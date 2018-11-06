FROM ocaml/opam2:ubuntu-18.04 as builder

MAINTAINER Ryan Foster <phasecorex@gmail.com>

ENV EXTRA_PACKAGES="taglib mad lame vorbis cry opus fdkaac faad"

RUN opam depext -i $EXTRA_PACKAGES liquidsoap;

RUN set -eux; \
    eval $(opam config env); \
    mkdir -p /home/opam/root; \
    mv $(which liquidsoap) /home/opam/root; \
    opam depext -ln $EXTRA_PACKAGES > /home/opam/root/depexts; \
    mkdir -p /home/opam/root/$OPAM_SWITCH_PREFIX/lib; \
    mv $OPAM_SWITCH_PREFIX/share /home/opam/root/$OPAM_SWITCH_PREFIX; \
    mv $OPAM_SWITCH_PREFIX/lib/liquidsoap /home/opam/root/$OPAM_SWITCH_PREFIX/lib;



FROM phasecorex/user-ubuntu:18.04 as runner

MAINTAINER Ryan Foster <phasecorex@gmail.com>

COPY --from=builder /home/opam/root /

RUN set -eux; \
    apt-get update; \
    cat /depexts | xargs apt-get install -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["user-entrypoint", "/liquidsoap"]
