[![Build Status](https://travis-ci.org/infiniteproject/liquidsoap.svg?branch=master)](https://travis-ci.org/infiniteproject/liquidsoap)
# Liquidsoap
Liquidsoap for Docker.

Configuration: a valid /srv/liquidsoap/radio.liq file is expected to run this image:

docker run -d -v ./radio.liq:/srv/liquidsoap/radio.liq:ro infiniteproject/liquidsoap
