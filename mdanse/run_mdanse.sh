#!/bin/bash

docker run -i -t --net=host -e DISPLAY -v $HOME/.Xauthority:/root/.Xauthority -v /home/pellegrini:/pellegrini mdanse:1.0.0
