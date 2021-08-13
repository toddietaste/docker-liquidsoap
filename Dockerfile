FROM ocaml/opam:debian-10-ocaml-4.13 as builder

ENV PACKAGES="taglib mad lame vorbis cry samplerate.0.1.5 opus fdkaac faad flac"

RUN set -eux; \
    sudo sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    sudo apt-get update; \
    sudo apt-get install -y --no-install-recommends autoconf automake ocaml-findlib \
        libcamomile-ocaml-dev libshout3-dev  libid3tag0-dev libasound2-dev  libpcre3-dev ;\
    for package in $PACKAGES; do \
        opam depext --install $package; \
    done ; \
    opam pin add liquidsoap https://github.com/savonet/liquidsoap/archive/refs/tags/v2.0.0-beta3.tar.gz 


RUN set -eux; \
    eval $(opam env); \
    mkdir -p /home/opam/root/app; \
    mv $(command -v liquidsoap) /home/opam/root/app; \
    opam depext --list $PACKAGES liquidsoap > /home/opam/root/app/depexts; \
    mkdir -p /home/opam/root/$OPAM_SWITCH_PREFIX/lib; \
    mv $OPAM_SWITCH_PREFIX/share /home/opam/root/$OPAM_SWITCH_PREFIX; \
    mv $OPAM_SWITCH_PREFIX/lib/liquidsoap /home/opam/root/$OPAM_SWITCH_PREFIX/lib



FROM phasecorex/user-debian:10-slim

COPY --from=builder /home/opam/root /

RUN set -eux; \
    sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    apt-get update; \
    cat /app/depexts | xargs apt-get install -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    /app/liquidsoap --version

ENTRYPOINT ["user-entrypoint", "/app/liquidsoap"]
