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
convert -geometry 256x256 ${target_image} tmp1.png
conver waku.png tmp1.png -gravity center -composite output.png

convert output.png waku.png -composite output.png
rm tmp1.png
echo "枠ついた！"
exit 0
