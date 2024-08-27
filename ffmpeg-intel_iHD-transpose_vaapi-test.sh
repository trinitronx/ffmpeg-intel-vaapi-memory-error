#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Tried forcing /usr/lib/dri/iHD_drv_video.so
# Same results
#export LIBVA_DRIVERS_PATH=/usr/lib/dri/
#export LIBVA_DRIVER_NAME=iHD

hw_dev_name='intel0'
hw_device='vaapi=intel0:/dev/dri/renderD128'

vf_dev_name='intel0'

#num_cpus=$(nproc --all | head -n1)
num_cpus=1  # Trying just 1 CPU... still gives memory error!

# Even very small video gives memory error... WTF?
input_testfile=${SCRIPT_DIR}/whitenoise-test-input-720x405.amd0.h264.mp4 # Test whitenoise video input 720x405


# Tried hevc encoding and/or scale_vaapi with very small dimensions
# It gave the same error: "Error while filtering: Cannot allocate memory"
# Command was originally to correct a 90° flipped iPhone video (`.mov`, HEVC 10-bit)
#    -vf 'format=nv12|vaapi,hwupload,scale_vaapi=w=320:h=180' \
#    -map 0:0 -c:v hevc_vaapi -global_quality 25 -profile:v:0 main10 \

ffmpeg -report -nostdin -v debug \
  -threads ${num_cpus} -init_hw_device ${hw_device} \
  -hwaccel vaapi -hwaccel_output_format vaapi -hwaccel_device ${hw_dev_name} \
  -i $input_testfile \
    -map 0:0 -c:v h264_vaapi -global_quality 25 -profile:v:0 main \
    -vf 'format=nv12|vaapi,hwupload,transpose_vaapi=clock' \
    -map 0:a -c:a copy \
  -f mp4 -y  ${SCRIPT_DIR}/out.mp4

