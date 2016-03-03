#!/bin/sh

sourcePath=~/Downloads/textfxpreview;
delay=40

for file in $sourcePath/*; do
    fileName=$(basename ${file});
    echo $fileName;

    apngasm ${file}/${fileName}*.png -o ${sourcePath}/${fileName}.png -d ${delay};
    test $? -gt 128 && break;
done