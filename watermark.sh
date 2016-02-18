#!/bin/sh

tempPath=~/Desktop/temp;
outputPath=~/Desktop/output;
watermark=~/Desktop/watermark.png;
sourcePath=~/Downloads/videos;

rm -rf $tempPath;
mkdir -p $tempPath;
rm -rf $outputPath;
mkdir -p $outputPath;

for file in $sourcePath/*; do
    fileName=$(basename ${file});
    tempFile="${tempPath}/${fileName}";
    outputFile="${outputPath}/${fileName}";
    echo $fileName;
    ffmpeg -i $file  -vf "scale=(iw * 640 / min(iw\, ih)):(ih * 640 / min(iw\, ih)),crop=640:640,setdar=1/1,setsar=1/1" $tempFile;
    test $? -gt 128 && break;
    ffmpeg -i $tempFile -i $watermark -filter_complex "overlay=480:20" -codec:a copy $outputFile;
    test $? -gt 128 && break;
done

