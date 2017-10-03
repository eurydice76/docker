#!/bin/sh

COMMAND=/bin/bash

# allow connections to X server
xhost +
docker run --privileged -e "DISPLAY=unix:0.0" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /home/pellegrini:/pellegrini -i -t mdanse $COMMAND
