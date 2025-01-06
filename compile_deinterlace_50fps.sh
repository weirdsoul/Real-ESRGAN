#!/bin/bash
source ./config.sh

#deint=nnedi=weights=/home/weirdsoul/coding/Real-ESRGAN/nnedi3_weights.bin:field=tf:qual=slow
#deint=bwdif,colorcorrect=analyze=median
deint=bwdif,frei0r=balanc0r:#b1d0fbff
ffmpeg -y -framerate 25 -i /media/bulk_data/superres/results/frame%08d_top_out.png -framerate 25 -i /media/bulk_data/superres/results/frame%08d_bottom_out.png -ss "${offset}" -t "${duration}" -i "${source_video}" -filter_complex "[1:v] setpts=PTS+TB/2[bottom];[0:v][bottom] interleave,scale=1408:576,tinterlace=merge,fieldorder=tff,${deint}[vout]" -c:v libx264 -f mp4 -pix_fmt yuv420p -r 50 -map '[vout]' -map 2:a /media/bulk_data/superres/output_videos/interlace_test.mp4
