[![Build Status](https://travis-ci.org/infiniteproject/liquidsoap.svg?branch=master)](https://travis-ci.org/infiniteproject/liquidsoap)
# Liquidsoap
Liquidsoap for Docker
```
docker run -d -v ./script.liq:/script.liq --link some-icecast infiniteproject/liquidsoap /script.liq
```
Liquidsoap is set as entrypoint so just provide script as first argument. Feedback appreciated!
