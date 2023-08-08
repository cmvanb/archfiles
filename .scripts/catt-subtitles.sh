#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Cast a video file with embedded subtitle tracks.
#
# Uses `ffmpeg` to extract the subtitles to a temporary file.
# Uses `catt` to cast the video to a chromecast receiver.
#
# Original author: https://github.com/EtienneM
#-------------------------------------------------------------------------------

script_name=`basename "$0"`

print_usage() {
    echo "$script_name [--map=0:3] video_file" >&2
    echo "" >&2
    echo "With video_file the path to a file like mkv which embeds the subtitles" >&2
    echo "--map: use the specified embedded subtitle." >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "$script_name --map=0:3 ./movie.mkv" >&2
}

map=""
while getopts ":-:" optchar; do
    [[ "${optchar}" == "-" ]] || continue
    case "${OPTARG}" in
        map=* )
            map=${OPTARG#*=}
            ;;
        help )
            print_usage
            exit -1
            ;;
    esac
done

# Remove from the list of arguments the one already handled by getopts
shift $(($OPTIND - 1))

if [[ $# -ne 1 ]]; then
    echo "Wrong number of arguments." >&2
    print_usage
    exit -1
fi

which ffmpeg > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Missing requirement ffmpeg: https://ffmpeg.org/download.html"
    exit -1
fi
ffmpeg_cmd="ffmpeg -loglevel warning"

which catt > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Missing requirement catt: https://github.com/skorokithakis/catt"
    exit -1
fi

if [[ -z "$map" ]]; then
    subtitles_count=$($ffmpeg_cmd -i "$1" 2>&1 | rg "Subtitle:" | wc -l)
    if [[ "$subtitles_count" -gt 1 ]]; then
        echo "There are multiple subtitle tracks in the video file. Pass --map argument to specify." >&2
        echo "To list the embedded subtitle tracks:" >&2
        echo "ffmpeg -i \"$1\" 2>&1 | rg \"Subtitle: \"" >&2
        exit -1
    else
        map=$($ffmpeg_cmd -i "$1" 2>&1 | rg "Subtitle:" | cut -d "#" -f2 | cut -d "(" -f1)
    fi
else
    ffmpeg -i "$1" 2>&1 | rg "Subtitle:" | rg $map > /dev/null
    if [[ $? -ne 0 ]]; then
        echo "Invalid map provided: $map"
        exit -1
    fi
fi

subtitles_file=$(mktemp --suffix=.srt --dry-run)

echo "Extracting subtitle track from the video file..."
$ffmpeg_cmd -i "$1" -map "$map" -f webvtt "$subtitles_file"

echo "Casting video file..."
catt cast --subtitles "$subtitles_file" "$1"
