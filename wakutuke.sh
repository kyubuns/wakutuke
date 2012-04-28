#!/bin/bash

if [ $# -ne 1 ]; then
  echo "引数は入力ファイル名だけやで！"
  exit 1
fi

if [ -e output.png ]; then
  echo "output.pngが既にあります！"
  exit 1
fi

if [ ! -e waku.png ]; then
  wget http://dl.dropbox.com/u/8511705/waku.png
fi

set -e
target_image=$1
eval $(identify -format 'width=%w; height=%h' $target_image)
if [ $width -lt $height ]; then
  size='174'
else
  size='x174'
fi

convert -geometry $size -gravity center -extent 174x174 ${target_image} tmp1.png
convert waku.png tmp1.png -gravity northwest -geometry +28+23 -composite output.png

convert output.png waku.png -composite output.png
rm tmp1.png
echo "枠ついた！"
exit 0
