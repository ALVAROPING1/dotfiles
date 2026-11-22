#!/usr/bin/env bash

DEFAULT_CQ=25

# Compress video
ffmpeg -i "$1" -profile:v main -preset p7 -c:v hevc_nvenc -rc vbr -b:v 400M -cq "$(($DEFAULT_CQ+$2))" out.mp4
