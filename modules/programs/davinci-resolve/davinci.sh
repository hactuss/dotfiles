#! /usr/bin/env nix-shell
ffmpeg -i your_video.MP4 -vsync 1 -async 1 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p converted_video.mov
