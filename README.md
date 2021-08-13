# Liquidsoap
Liquidsoap 2 (currently v2.0.0-beta3) for Docker

based on phasecorex version, changed to build specific version of liquidsoap from source instead of using OPAM-Version (which would be latest stable release, currently still 1.4.4). 

Intended for providing an Armv7/32bit docker container of Liquidsoap2, i.e. for use with non 64-bit Raspberry Pi OS, since Savonet-provided official docker containers for liquidsoap2 are (currently) only available for 64bit-OS (and do only provide a minimal set of enabled libraries). 


Assuming you have a folder `/music` with a liquidsoap script file in it:
```
docker build -t liquidsoap2 .
docker run --link some-icecast -v /music:/music:ro liquidsoap2 /music/script.liq
```
This has been heavily modified from infiniteproject/liquidsoap:
- Added support for opus, flac, and m4a/aac files
- Much smaller image size (203MB instead of 1.66GB)
- Multiarch support
    - You can run it on a Raspberry Pi if you want to.
- Runs as non-root user
	- You can set environment variable `PUID` to whatever user ID you want Liquidsoap to run as. Defaults to 1000.
	- You can also set `PGID` to a group ID you want Liquidsoap to run as. If you don't, it defaults to whatever the UID is set to.
- Timezone support
	- You can set environment variable `TZ` to a timezone (e.g. `TZ=America/Detroit`) so that Liquidsoap logs are in your timezone.
- Niceness support
    - You can set environment variable `NICENESS` to a value from -20 to 19 to set the niceness of the Liquidsoap process.

Feedback appreciated!
