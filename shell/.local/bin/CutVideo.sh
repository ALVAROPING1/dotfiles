#!/bin/bash

# Open video
xdg-open "$1" 2> /dev/null

# Print keyframes:
echo "Keyframe time stamps:"
ffprobe -loglevel error -skip_frame nokey -select_streams v:0 -show_entries frame=pts_time -of csv=print_section=0 "$1"
echo ""

# Cut video:
read -p "Enter start time: " start
read -p "Enter end time (empty=end): " end

if [ -z "${end}" ]
then
    ffmpeg -ss "$start" -i "$1" -c copy -avoid_negative_ts 1 out.mp4
else
    ffmpeg -ss "$start" -to "$end" -i "$1" -c copy -avoid_negative_ts 1 out.mp4
fi
