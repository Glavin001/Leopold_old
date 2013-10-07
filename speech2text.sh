#!/bin/bash

echo "Recording... Press Ctrl+C to Stop."
# arecord -D "plughw:1,0" -q -f cd -t wav | ffmpeg -loglevel panic -y -i - -ar 16000 -acodec flac file.flac  > /dev/null 2>&1

rec ./temp/rec.mp3 rate 16k silence 1 0.1 3% 1 2.0 3%
echo "Converting..."
ffmpeg -i ./temp/rec.mp3 -ar 16000 -c:a flac ./temp/rec.flac > /dev/null 2>&1

echo "Processing..."
wget -q -U "Mozilla/5.0" --post-file ./temp/rec.flac --header "Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium" | cut -d\" -f12  > ./temp/stt.txt

echo -n "You Said: "
cat ./temp/stt.txt

# rm ./temp/rec.flac  > /dev/null 2>&1

