FROM ubuntu:18.04 as builder

MAINTAINER Ryan Foster <phasecorex@gmail.com>

RUN set -ex; \
    buildDeps=' \
        aspcud \
        ca-certificates \
        camlp4-extra \
        curl \
        make \
        ocaml \
        opam \
    '; \
    liquidDeps=' \
        libfaad-dev \
        libfdk-aac-dev \
        libmad0-dev \
        libmp3lame-dev \
        libogg-dev \
        libopus-dev \
        libpcre3-dev \
        libtag1-dev \
        libvorbis-dev \
        m4 \
        pkg-config \
    '; \
    apt-get update; \
    apt-get install -y --no-install-recommends $liquidDeps $buildDeps; \
    adduser --system opam;

USER opam

WORKDIR /home/opam

ENV PACKAGES="taglib mad lame vorbis cry opus fdkaac faad liquidsoap"

RUN set -ex; \
    opam init -y; \
    eval $(opam config env); \
    # We need depext later on, so we install it here
    opam depext -i $PACKAGES;

RUN set -ex; \
    eval $(opam config env); \
    mkdir -p /home/opam/root; \
    mv $(which liquidsoap) /home/opam/root; \
    opam depext -ln $PACKAGES | egrep -o "\-\s.*" | sed "s/- //" > /home/opam/root/depexts; \
    mkdir -p /home/opam/root/home/opam/.opam/system/lib; \
    mv /home/opam/.opam/system/share /home/opam/root/home/opam/.opam/system; \
    mv /home/opam/.opam/system/lib/liquidsoap /home/opam/root/home/opam/.opam/system/lib;



FROM ubuntu:18.04 as runner

COPY --from=builder /home/opam/root /

RUN set -ex; \
    adduser --system opam; \
    apt-get update; \
    cat /depexts | xargs apt-get install -y --no-install-recommends; \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*;

USER opam

ENTRYPOINT ["/liquidsoap"]
