# Liquidsoap
Liquidsoap for Docker

[![Donate to support my code](https://img.shields.io/badge/Paypal-Donate-blue.svg)](https://paypal.me/pcx)

Assuming you have a folder `/music` with a liquidsoap script file in it:
```
docker run --link some-icecast -v /music:/music:ro phasecorex/liquidsoap /music/script.liq
```
This has been heavily modified from infiniteproject/liquidsoap:
- Added support for opus, flac, and m4a/aac files
- Much smaller image size (215MB instead of 1.66GB)
- Runs as non-root user
	- You can set environment variable `PUID` to whatever user ID you want Liquidsoap to run as. Defaults to 1000.
	- You can also set `PGID` to a group ID you want Liquidsoap to run as. If you don't, it defaults to whatever the UID is set to.
- Timezone support
	- You can set environment variable `TZ` to a timezone (e.g. `TZ=America/Detroit`) so that Liquidsoap logs are in your timezone.

Feedback appreciated!
