FROM debian:latest
MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r liquidsoap --gid=888 && useradd -r -g liquidsoap --uid=888 liquidsoap

RUN apt-get update && apt-get install -y --no-install-recommends liquidsoap liquidsoap-plugin-all && \
    apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER liquidsoap
EXPOSE 8005

CMD ["liquidsoap", "--interactive"]
