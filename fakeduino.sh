#!/bin/bash

# options
GCC=g++
GCC_OPTIONS="-Wall"
OUT=/tmp/fakeduino

# this kinda sucks but is only reliable OSX/Linux solution afaik
# prints absolute path of a single file, resolving symbolic links
function absolute_path() {
    pushd "$(dirname "$1")" >/dev/null
    file="$(pwd)/$(basename "$1")"
    popd >/dev/null
    absfile=$(readlink "$file")
    [[ -e "$absfile" ]] && echo $absfile && return
    [[ -e "$file" ]] && echo $file
}
# runs absolute_path() on files via pipe or command line
function realpath() {
    if [[ -z "$@" ]]; then
        while read file; do absolute_path "$file"; done
    else
        for file in $@; do absolute_path "$file"; done
    fi
}

INCLUDEPATH="$( realpath "${BASH_SOURCE[0]}" | xargs dirname )/include"
INCLUDELIST="$( find "$INCLUDEPATH" -name \*.cpp )"
PARAMS="$@"
[[ -e "$PARAMS" ]] || PARAMS=$( ls *.cpp )

# find any CPP files that need to be built along with the main program
# this is pretty hacky but it works (in theory)
DEPS=$( sed -ne 's/^#include "\(.*\).h"$/\1.cpp/p' "$PARAMS" | uniq | realpath)

cmdline="$GCC $GCC_OPTIONS -I$INCLUDEPATH $INCLUDELIST $DEPS $PARAMS -o $OUT"
echo $cmdline
$cmdline && $OUT
rm $OUT 2>/dev/null
