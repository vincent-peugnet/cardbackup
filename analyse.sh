#!/bin/bash

filename=$(basename "$1")
FileSize=$(mediainfo --Inform="General;%FileSize%" "$1")
FileSizeString4=$(mediainfo --Inform="General;%FileSize/String3%" "$1")

echo -e "\n"
echo -e "\e[34m\e[1mfilename           : $filename\e[0m"
echo "size               : $FileSizeString4"
echo "size (bytes)       : $FileSize"


# Check if the file contain video stream

VideoCount=$(mediainfo --Inform="General;%VideoCount%" "$1")
if [[ -n $VideoCount ]]
then
    Format=$(mediainfo --Inform="General;%Format%" "$1")
    Duration=$(mediainfo --Inform="Video;%Duration%" "$1")
    DurationString4=$(mediainfo --Inform="Video;%Duration/String4%" "$1")
    VideoFormat=$(mediainfo --Inform="Video;%Format%" "$1")
    FrameRateString=$(mediainfo --Inform="Video;%FrameRate/String%" "$1")
    WidthString=$(mediainfo --Inform="Video;%Width/String%" "$1")
    HeightString=$(mediainfo --Inform="Video;%Height/String%" "$1")
    BitRateString=$(mediainfo --Inform="Video;%BitRate/String%" "$1")
    AspectRatio=$(mediainfo --Inform="Video;%DisplayAspectRatio%" "$1")
    ScanTypeString=$(mediainfo --Inform="Video;%ScanType/String%" "$1")
    ChromaSubsamplingString=$(mediainfo --Inform="Video;%ChromaSubsampling/String%" "$1")
    BitDepthString=$(mediainfo --Inform="Video;%BitDepth/String%" "$1")

    echo "format             : $Format"
    echo "videoformat        : $VideoFormat"
    echo "framerate          : $FrameRateString"
    echo "width              : $WidthString"
    echo "height             : $HeightString"
    echo "duration           : $DurationString4"
    echo "bitrate            : $BitRateString"
    echo "aspect ratio       : $AspectRatio"
    echo "scan type          : $ScanTypeString"
    echo "chroma subsampling : $ChromaSubsamplingString"
    echo "bit depth          : $BitDepthString"
    
    

    # Screenshots

    sdir="./screenshots/"
    mkdir -p $sdir

    let "d = $Duration"
    let "d = d / 1000"
    let "m = d / 2"
    let "l = d - 1"
    ffmpeg -y -loglevel fatal -ss 1 -i "$1" -vframes 1 -q:v 2 "$sdir$filename"_screenshot0.jpg
    ffmpeg -y -loglevel fatal -ss $m -i "$1" -vframes 1 -q:v 2 "$sdir$filename"_screenshot1.jpg
    ffmpeg -y -loglevel fatal -ss $l -i "$1" -vframes 1 -q:v 2 "$sdir$filename"_screenshot2.jpg


fi


}
export -f analyse



