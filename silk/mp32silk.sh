#!/bin/bash

# Colors
RED="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"
GREEN="$(tput setaf 2 2>/dev/null || echo '\e[0;32m')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"
WHITE="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"
RESET="$(tput sgr 0 2>/dev/null || echo '\e[0m')"

# Main
cur_dir=$(cd `dirname $0`; pwd)

if [ ! -r "$cur_dir/silk-v3-decoder/decoder" ]; then
    echo -e "${WHITE}[Notice]${RESET} Silk v3 Decoder is not found, compile it."
    cd $cur_dir/silk-v3-decoder
    make && make decoder
    [ ! -r "$cur_dir/silk-v3-decoder/decoder" ]&&echo -e "${RED}[Error]${RESET} Silk v3 Decoder Compile False, Please Check Your System For GCC."&&exit
    echo -e "${WHITE}========= Silk v3 Decoder Compile Finish =========${RESET}"
fi

cd $cur_dir

if [ ! -r "$1" ]; then
    echo -e "${RED}[Error]${RESET} Input file not found, please check it."&&exit
fi

if [ ! -d "$2" ]; then
    mkdir "$2"
fi

ffmpeg -i "$1" -f s16le -acodec pcm_s16le -ar 24000 -ac 1 - > "$2/output.pcm"
if [ ! -f "$2/output.pcm" ]; then
    echo -e "${YELLOW}[Warning]${RESET} Convert false, please check it."&&exit
fi

$cur_dir/silk-v3-decoder/decoder "$2/output.pcm" "$2/output.silk"
if [ -f "$2/output.silk" ]; then
    echo -e "${GREEN}[OK]${RESET} Convert $1 to $2/output.silk Finish."
else
    echo -e "${YELLOW}[Warning]${RESET} Convert false, please check it."
fi

rm "$2/output.pcm"

exit
