FROM ocaml/opam:latest
LABEL maintainer "phasecorex@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGES "taglib mad lame vorbis cry opus fdkaac faad liquidsoap"

RUN sudo sed -i "s/stable main/stable main non-free/" /etc/apt/sources.list

RUN sudo apt-get update

RUN opam depext $PACKAGES && \
    opam install $PACKAGES

RUN sudo apt-get -y autoremove && \
    sudo apt-get clean && \
    sudo rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
