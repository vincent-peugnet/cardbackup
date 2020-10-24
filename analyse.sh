#!/bin/bash

TMP_DIR=${TMP_DIR:-$(mktemp -dt cardbackup-XXXXXXXX)}

echo "temporary directory : $TMP_DIR"

filename=$(basename "$1")
FileSize=$(mediainfo --Inform="General;%FileSize%" "$1")
FileSizeString4=$(mediainfo --Inform="General;%FileSize/String3%" "$1")

echo -e "\n"
echo -e "\e[34m\e[1mfilename           : $filename\e[0m"


echo "\\subsection{\\lstinline{$filename}}" >> $TMP_DIR/summary.tex

echo "\\Verb!$1!" >> $TMP_DIR/summary.tex

echo "\\subsubsection{mediainfo}" >> $TMP_DIR/summary.tex

echo "\\begin{Verbatim}" >> $TMP_DIR/summary.tex

echo "size               : $FileSizeString4" | tee -a $TMP_DIR/summary.tex
echo "size (bytes)       : $FileSize" | tee -a $TMP_DIR/summary.tex



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

    echo "format             : $Format" | tee -a $TMP_DIR/summary.tex
    echo "videoformat        : $VideoFormat" | tee -a $TMP_DIR/summary.tex
    echo "framerate          : $FrameRateString" | tee -a $TMP_DIR/summary.tex
    echo "width              : $WidthString" | tee -a $TMP_DIR/summary.tex
    echo "height             : $HeightString" | tee -a $TMP_DIR/summary.tex
    echo "duration           : $DurationString4" | tee -a $TMP_DIR/summary.tex
    echo "bitrate            : $BitRateString" | tee -a $TMP_DIR/summary.tex
    echo "aspect ratio       : $AspectRatio" | tee -a $TMP_DIR/summary.tex
    echo "scan type          : $ScanTypeString" | tee -a $TMP_DIR/summary.tex
    echo "chroma subsampling : $ChromaSubsamplingString" | tee -a $TMP_DIR/summary.tex
    echo "bit depth          : $BitDepthString" | tee -a $TMP_DIR/summary.tex


    echo "\\end{Verbatim}" >> $TMP_DIR/summary.tex

    # Screenshots

    screendir="$TMP_DIR/screenshots"
    mkdir $screendir

    md5=$(echo $1 | md5sum | cut -d' ' -f1)
    echo $md5

    let "d = $Duration"
    let "d = d / 1000"
    let "m = d / 2"
    let "l = d - 1"
    ffmpeg -y -loglevel fatal -ss 1 -i "$1" -vframes 1 -q:v 2 "$screendir/$md5-screenshot0.jpg"
    ffmpeg -y -loglevel fatal -ss $m -i "$1" -vframes 1 -q:v 2 "$screendir/$md5-screenshot1.jpg"
    ffmpeg -y -loglevel fatal -ss $l -i "$1" -vframes 1 -q:v 2 "$screendir/$md5-screenshot2.jpg"

    echo "\\subsubsection{screenshots}" >> $TMP_DIR/summary.tex
    echo "\\noindent" >> $TMP_DIR/summary.tex
    echo "\\begin{tabular}{lll}" >> $TMP_DIR/summary.tex
    echo "\\includegraphics[width=0.3\\textwidth]{$screendir/$md5-screenshot0.jpg} &" >> $TMP_DIR/summary.tex
    echo "\\includegraphics[width=0.3\\textwidth]{$screendir/$md5-screenshot1.jpg} &" >> $TMP_DIR/summary.tex
    echo "\\includegraphics[width=0.3\\textwidth]{$screendir/$md5-screenshot2.jpg} \\\\" >> $TMP_DIR/summary.tex
    echo "\\end{tabular}" >> $TMP_DIR/summary.tex


else
    echo "\\end{Verbatim}" >> $TMP_DIR/summary.tex
fi




