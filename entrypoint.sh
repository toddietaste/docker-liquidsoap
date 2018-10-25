#!/bin/sh

eval $(opam config env)
liquidsoap $@
