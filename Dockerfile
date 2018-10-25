FROM ubuntu:18.04

MAINTAINER Ryan Foster <phasecorex@gmail.com>

ENV PACKAGES "taglib mad lame vorbis cry opus fdkaac faad liquidsoap"

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends aspcud bash ca-certificates curl gzip m4 make ocaml opam sudo; \
    adduser --system opam; \
    echo 'opam ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/opam; \
    chmod 440 /etc/sudoers.d/opam; \
    chown root:root /etc/sudoers.d/opam; \
    sed -i.bak 's/^Defaults.*requiretty//g' /etc/sudoers; \
    rm -rf /tmp/* \
        /var/tmp/*;

USER opam

WORKDIR /home/opam

RUN set -ex; \
    opam init -y; \
    eval $(opam config env); \
    opam depext -i $PACKAGES;

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
