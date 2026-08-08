#!/bin/bash
set -e
PASCAL="fpc"
OUT_DIR="output"
FLAGS="-FE$OUT_DIR -Co -Cr -Miso -gl"

mkdir -p "$OUT_DIR"

if [ -z "$1" ]; then
    printf "Error: You must provide a filename.\n"
    printf "Usage: %s <filename>\n" "$0"
    exit 1
fi

BASENAME=$(basename "$1")

echo "> $PASCAL $FLAGS $BASENAME.pas"
if $PASCAL $FLAGS "$BASENAME.pas"; then
    echo ""
    echo "Running $BASENAME.pas..."
    echo ""
    echo "Output:"
    "./$OUT_DIR/$BASENAME"
else
    echo "Compilation failed." >&2
    exit 1
fi

rm -r "./$OUT_DIR"