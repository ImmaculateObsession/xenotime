#!/bin/bash

#MAX_WIDTH is the maximum width you want a tilemap to be (multiple of 64!)
MAX_WIDTH=768
#768 is 12 units

if [[ $# != 2 ]]; then
    echo $0 export_list.txt tilemap_out.png
    exit 1
fi

EXP_LIST=$1
OUTFILE=$2

OUTPUT_ORDER=""
for IMAGE in `cat $EXP_LIST`; do
    if [[ "$IMAGE" == *pipe* ]]
        then
            for angle in 90 180 270; do
                convert -rotate $angle $IMAGE auto_gen/${IMAGE%%.*}.$angle.png
            done
    fi
    convert -crop 64x64 $IMAGE auto_gen/$IMAGE
    OUTPUT_ORDER=$OUTPUT_ORDER" "auto_gen/${IMAGE%%.*}*.png
done
NUMBER_IMAGES=0
for I in $OUTPUT_ORDER; do
    NUMBER_IMAGES=$((NUMBER_IMAGES+1))
done
HEIGHT=$(((1+(NUMBER_IMAGES/(MAX_WIDTH/64)))))
WIDTH=$((MAX_WIDTH/64))

montage $OUTPUT_ORDER -tile $WIDTH"x"$HEIGHT -geometry 64x64 -background none $OUTFILE
