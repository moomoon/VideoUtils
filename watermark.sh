#!/bin/sh

tempPath=~/Desktop/temp;
outputPath=~/Desktop/output;
watermark=~/Desktop/watermark.png;
sourcePath=~/Downloads/videos;

rm -rf $tempPath;
mkdir -p $tempPath;
rm -rf $outputPath;
mkdir -p $outputPath;

trap "exit" INT

for file in $sourcePath/*; do
    fileName=$(basename ${file});
    tempFile="${tempPath}/${fileName}";
    outputFile="${outputPath}/${fileName}";
    echo $fileName;
    ffmpeg -i $file  -vf "scale=(iw * 640 / min(iw\, ih)):(ih * 640 / min(iw\, ih)),crop=640:640,setdar=1/1,setsar=1/1" $tempFile;
    ffmpeg -i $tempFile -i $watermark -filter_complex "overlay=480:20" -codec:a copy $outputFile;
done

