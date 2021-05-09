#!/bin/bash

if [ ! "$#" -eq 3 ]; then
    echo "Usage ./${0##*/} <program> <tests folder> <crashes folder>"
    exit 1
fi

if [ ! -e "$1" ]; then
    echo "Program not found"
    exit 1
fi

if ! command -v "$1" > /dev/null; then
    echo "Cannot execute command (Consider using './')"
    exit 1
fi

if [ ! -d "$2" ] || [ ! -d "$3" ]; then
    echo "Folder does not exist"
    exit 1
fi

if [ "$2" = "$3" ]; then
    echo "Please do not use the same directory for test cases and crashes"
    exit 1
fi

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

TRIES=700

ret=0
for file in $(find "$2" -type f); do
    found=0

    for i in $(seq 1 $TRIES);
    do
        radamsa "$file" > /tmp/fuzzed.sh
        # Redirecting segmentation fault message
        { cat /tmp/fuzzed.sh | timeout 1 "$1" > /dev/null 2> /dev/null; } 2> /dev/null
        if test $? -gt 127; then
            echo -e "${RED}Crash found for ${file} saved at $3/$(basename ${file}).fuzz${NC}"
            cp /tmp/fuzzed.sh "$3/$(basename ${file}).fuzz"
            found=1
            ret=1
            break;
        fi
    done

    if [ $found -eq 0 ];then
        echo -e "${GREEN}Nothing for ${file}${NC}"
    fi
done

exit "$ret"
