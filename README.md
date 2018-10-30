
# Liquidsoap
Liquidsoap for Docker
```
docker run --link some-icecast phasecorex/liquidsoap script.liq
```
This has been heavily modified from infiniteproject/liquidsoap:
-  Added support for opus and m4a/aac files
- Much smaller image size (1.66GB down to 58MB)
- User and Timezone support
	- You can set `PUID` to whatever UID you want Liquidsoap to run as (though since we aren't writing anything to disk, this might not be needed)
	- You can optionally set `PGID` to a GID you want Liquidsoap to run as. If not, it defaults to whatever the UID is.
	- You can set `TZ` to a timezone (e.g. `TZ=America/Detroit`) so that Liquidsoap logs are in your timezone.

Feedback appreciated!

