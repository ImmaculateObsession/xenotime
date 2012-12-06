#!/bin/bash

#MAX_WIDTH is the maximum width you want a tilemap to be (multiple of 64!)
MAX_WIDTH=768
#768 is 12 units

if [[ $# != 2 ]]; then
  echo $0 export_list.txt tilemap_out.png
fi

EXP_LIST=$1
OUTFILE=$2

OUTPUT_ORDER=""
for IMAGE in `cat $EXP_LIST`; do
   convert -crop 64x64 $IMAGE auto_gen/$IMAGE
   OUTPUT_ORDER=$OUTPUT_ORDER `ls auto_gen/${IMAGE%%.*}*.png`
done
NUMBER_IMAGES=`echo $OUTPUT_ORDER | wc -c`
HEIGHT=$(((1+(NUMBER_IMAGES/(MAX_WIDTH/64)))*64))

montage $OUTPUT_ORDER -geometry $WIDTH"x"$HEIGHT $OUTFILE
