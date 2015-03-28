#!/bin/bash

case $# in
  1)
    out_image="output.png"
    ;;
  2)
    out_image=$2
    ;;
  *)
    echo "引数はこんな感じやで！"
    echo "  $0 infile.png"
    echo "  $0 infile.png output.png"
    echo "出力ファイルを省略するとoutput.pngになるで！"
    exit 1
    ;;
esac

if [ -e $out_image ]; then
  echo "${out_image}が既にあるで！"
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

tmp_image=$(/bin/mktemp /tmp/waku.XXXXXX)
trap "rm -f ${tmp_image}" EXIT

convert -geometry $size -gravity center -extent 174x174 ${target_image} ${tmp_image}
convert waku.png ${tmp_image} -gravity northwest -geometry +28+23 -composite ${out_image}

convert ${out_image} waku.png -composite ${out_image}
echo "枠ついたで！"
exit 0
