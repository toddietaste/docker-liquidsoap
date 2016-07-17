[![Build Status](https://travis-ci.org/infiniteproject/liquidsoap.svg?branch=master)](https://travis-ci.org/infiniteproject/liquidsoap)
# Liquidsoap
Liquidsoap for Docker
```
docker run -d -v ./script.liq:/script.liq --link some-icecast infiniteproject/liquidsoap /script.liq
```
Liquidsoap is set as entrypoint so just provide a .liq script like https://github.com/savonet/liquidsoap/blob/master/examples/radio.liq as CMD. Feedback appreciated!
