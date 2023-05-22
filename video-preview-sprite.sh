#!/bin/bash

INPUT="$1"
OUTPUT="$2"
FRAMES=200

# Extract video duration in seconds
DURATION_S=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $INPUT)
echo x
# Calculate the FPS if we want to show 20 frames in our sprite sheet
FPS=$(echo "scale=8; $FRAMES / $DURATION_S" | bc)
echo y
# Generate the sprite sheet
ffmpeg \
  -y \
  -i "$INPUT" \
  -frames 1 \
  -q:v 2 \
  -filter_complex "fps=$FPS,pad=width=max(iw\,ih*(16/9)):height=ow/(16/9):x=(ow-iw)/2:y=(oh-ih)/2,scale=-1:135:force_original_aspect_ratio=decrease,tile=1x$FRAMES" \
  $OUTPUT

echo z

