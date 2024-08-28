# Takes a HEVC video in a different container (MKV, AVI, etc) and repackages it in an MP4 container
transcodeHEVC() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    out="$(pwd)/${base}mp4"

    ffmpeg -i "$file" -metadata:s:a:0 language=eng -metadata:s:a:0 title="ENG" -c copy -c:s mov_text -tag:v hvc1 "$out"
    trash "$file"
}

transcodeHEVCAll() {
    for file in "$1"/**/*(.); do
        transcodeHEVC "$file"
    done
}

transcodeWSubs() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    out="$(pwd)/${base}mp4"

    ffmpeg -i "$file" -metadata:s:a:0 language=eng -metadata:s:a:0 title="ENG" -c:v copy -c:a copy -c:s mov_text "$out"
    trash "$file"
}

transcodeAllWSubs() {
    for file in "$1"/**/*(.); do
        transcodeWSubs "$file"
    done
}

transcode() {
    file="$1"
    transcodeWSubs "$file"
}

transcodeAll() {
    for file in "$1"/**/*(.); do
        transcode "$file"
    done
}

transcodeNoSub() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    out="$(pwd)/${base}mp4"

    ffmpeg -i "$file" -c copy "$out"
    trash "$file"
}

transcodeAllNoSub() {
    for file in "$1"/**/*(.); do
        transcodeNoSub "$file"
    done
}

convert() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    out="$(pwd)/${base}mp4"
    
    ffmpeg -i "$file" -metadata:s:a:0 language=eng -metadata:s:a:0 title="ENG" -c:v libx265 -tag:v hvc1 -crf 23 -c:a eac3 -b:a 320k -c:s mov_text "$out"
    trash "$file"
}

convertAll() {
    for file in "$1"/**/*(.); do
        convert "$file"
    done
}

# Tag HEVC MP4 files with the `hvc1` tag so they display correctly on Apple platforms
tag() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    tagged="$(pwd)/${base}-tagged.mp4"
    out="$(pwd)/${base}mp4"
    
    ffmpeg -i "$file" -c copy -c:s mov_text -tag:v hvc1 "$tagged"
    trash "$file"
    mv "$tagged" "$out"
    echo "$tagged"
    echo "$out"
}

tagAll() {
    for file in "$1"/**/*(.); do
        tag "$file"
    done
}

tagNoSubs() {
    file="$1"
    ext="${file##*.}"
    base=$(basename $file $ext)
    tagged="$(pwd)/${base}-tagged.mp4"
    out="$(pwd)/${base}mp4"
    
    ffmpeg -i "$file" -c copy -tag:v hvc1 "$tagged"
    trash "$file"
    mv "$tagged" "$out"
    echo "$tagged"
    echo "$out"
}

tagAllNoSubs() {
    for file in "$1"/**/*(.); do
        tagNoSubs "$file"
    done
}

ffsub() {
    video="$1"
    subs="$2"

    video_ext="${file##*.}"
    video_base=$(basename $video $video_ext)
    subbed="$(pwd)/${base}-subbed.mp4"

    output="$video"

    ffmpeg -i "$video" -i "$subs" -c copy -c:s mov_text \
    -metadata:s:a:0 language=eng -metadata:s:a:0 title="ENG" \
    -metadata:s:s:0 language=eng -metadata:s:s:0 title="ENG" \
    "$subbed"

    trash "$video"
    trash "$subs"

    mv -v "$subbed" "$output"
}

hevcVideo() {
    file="$1"
    file_name=$file:t:r

    echo "Converting $file_name to HEVC..."

    input="$(pwd)/${file_name}.x264.mp4"
    tmp_output="$(pwd)/${file_name}.x265.mp4"
    output="$(pwd)/${file_name}.mp4"

    mv "$file" "$input"
    ffmpeg -i "$input" -c:v libx265 -tag:v hvc1 -crf 23 -c:a eac3 -b:a 320k "$tmp_output"
    mv "$tmp_output" "$output"
    trash "$input"

    echo "Converted $output to HEVC!"
}

hevcAll() {
    for file in "$1"/**/*(.); do
        isHevc="$(ffprobe -v error -select_streams v -show_entries stream=codec_name,codec_type -of default=noprint_wrappers=1 "$file" | grep hevc)"

        # Not HEVC; -z == empty string
        if [ -z $isHevc ]; then
            hevcVideo "$file"
        else
            file_name=$file:t:r
            echo "Skipping $file_name; Already HEVC"
        fi
    done
}