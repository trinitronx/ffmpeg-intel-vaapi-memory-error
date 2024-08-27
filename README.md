# Intel iHD Memory Error Minimal Reproduction Test Case

A test script and `.mp4` file (containing whitenoise) to reproduce the error:

    Error while filtering: Cannot allocate memory

Example report logs are found in file: [`ffmpeg-20240827-091850.log`](./ffmpeg-20240827-091850.log)

## Dependencies

 - A system with [Intel iHD driver][2], and DRI render node: `/dev/dri/renderD128`
 - [`git-lfs`][1]: To checkout this git repo
 - `ffmpeg`
 - POSIX shell: `/bin/sh`

## Running Reproduction Script

1. Ensure you have [`git-lfs` installed][1]
2. Checkout the git repo:

       git clone https://github.com/trinitronx/ffmpeg-intel-vaapi-memory-error.git
       cd ffmpeg-intel-vaapi-memory-error

3. Run the script to reproduce the error:

       ./ffmpeg-intel_iHD-transpose_vaapi-test.sh


[1]: https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage
[2]: https://github.com/intel/media-driver
