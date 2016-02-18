#!/bin/sh

temp=~/Desktop/temp;
output=~/Desktop/output;
watermark=~/Desktop/watermark.png;
sourcePath=~/Downloads/videos/;

rm -rf $temp;
mkdir -p $temp;
rm -rf $output;
mkdir -p $output;

for file in $sourcePath/*
do
name=$(basename $file);
echo $name;
ffmpeg -i $file  -vf "scale=(iw * 640 / min(iw\, ih)):(ih * 640 / min(iw\, ih)),crop=640:640,setdar=1/1,setsar=1/1" $temp/$name;
done


for file in $temp/*
do
name=$(basename $file);
echo $name;
ffmpeg -i $file -i $watermark -filter_complex "overlay=480:20" -codec:a copy $output/$name;
done
