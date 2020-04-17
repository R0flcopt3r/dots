#!/usr/bin/env bash

usage (){
	cat <<EOF
Usage:
$0 [options]

Options:
	-h:		help
	-o <file>:	output, default out.mp4
	-i <file>:	input, default screen.mp4
	-s <seconds>:	sample start time, default 0
	-e <seconds>:	sample end time, default 5
	-b <bitrate>:	audio bitrate, default 44k

Requires:
	sox
	ffmpeg
EOF
}

clean(){
	rm tmpaud-clean.wav tmpvid.mp4 tmpaud.wav
}

output="out.mp4"
input="screen.mp4"
sample_start=0
sample_end=5
audio_bitrate="44k"

while getopts "h:o:i:s:e:b" options
do
	case "${options}" in
		h) usage; exit 0
		   ;;
		o) output=${OPTARG}
		   ;;
		i) input=${OPTARG}
		   ;;
		s) sample_start=${OPTARG}
		   ;;
		e) sample_end=${OPTARG}
		   ;;
		b) audio_bitrate=${OPTARG}
		   ;;
		:) usage; exit 1
		   ;;
		*) usage; exit 0
		   ;;
	esac
done



# The VIDEO stream:
ffmpeg -i "$input" -vcodec copy -an tmpvid.mp4

# The AUDIO stream:
ffmpeg -i "$input" -acodec pcm_s16le -ar "$audio_bitrate" -vn tmpaud.wav

# Noise clip
ffmpeg -i "$input" -acodec pcm_s16le -ar "$audio_bitrate" -vn -ss "$sample_start" -t "$sample_end" noiseaud.wav

# Noise profile
sox noiseaud.wav -n noiseprof noise.prof

# Clean it up
sox tmpaud.wav tmpaud-clean.wav noisered noise.prof 0.21

# Result
ffmpeg -i tmpvid.mp4 -i tmpaud-clean.wav -map 0:v -map 1:a -c:v copy -c:a aac -b:a "$audio_bitrate" "$output"

# Cleanup
clean
