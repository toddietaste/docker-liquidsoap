FROM debian:jessie
MAINTAINER Matthias Neugebauer <mtneug@mailbox.org>

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends liquidsoap liquidsoap-plugin-all \
 && rm -rf /var/lib/apt/lists/*

CMD ["liquidsoap"]
