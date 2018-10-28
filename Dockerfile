FROM ocaml/opam2:alpine-3.8 as builder

MAINTAINER Ryan Foster <phasecorex@gmail.com>

ENV PACKAGES="taglib mad lame vorbis cry opus fdkaac faad liquidsoap"

# Can be removed once fdk-aac-dev makes it into a repo
ADD https://dl-3.alpinelinux.org/alpine/edge/testing/x86_64/fdk-aac-dev-0.1.6-r0.apk /tmp
ADD https://dl-3.alpinelinux.org/alpine/edge/testing/x86_64/fdk-aac-0.1.6-r0.apk /tmp
RUN sudo apk add --no-cache --allow-untrusted /tmp/fdk-aac-dev-0.1.6-r0.apk /tmp/fdk-aac-0.1.6-r0.apk

RUN opam depext -i $PACKAGES 

RUN set -eux; \
    eval $(opam config env); \
    mkdir -p /home/opam/root; \
    mv $(which liquidsoap) /home/opam/root; \
    opam depext -ln $PACKAGES > /home/opam/root/depexts; \
    mkdir -p /home/opam/root/$OPAM_SWITCH_PREFIX/lib; \
    mv $OPAM_SWITCH_PREFIX/share /home/opam/root/$OPAM_SWITCH_PREFIX; \
    mv $OPAM_SWITCH_PREFIX/lib/liquidsoap /home/opam/root/$OPAM_SWITCH_PREFIX/lib;

# Can be removed once fdk-aac-dev makes it into a repo
RUN set -eux; \
    mkdir -p /home/opam/root/tmp; \
    sudo chmod 444 /tmp/fdk-aac-dev-0.1.6-r0.apk /tmp/fdk-aac-0.1.6-r0.apk; \
    cp /tmp/fdk-aac-dev-0.1.6-r0.apk /tmp/fdk-aac-0.1.6-r0.apk /home/opam/root/tmp;



FROM phasecorex/user-alpine:3.8 as runner

MAINTAINER Ryan Foster <phasecorex@gmail.com>

COPY --from=builder /home/opam/root /

RUN set -eux; \
    # This line can be removed once fdk-aac-dev makes it into a repo
    apk add --no-cache --allow-untrusted /tmp/fdk-aac-dev-0.1.6-r0.apk /tmp/fdk-aac-0.1.6-r0.apk; \
    cat /depexts | xargs apk add --no-cache;

CMD ["/liquidsoap"]
