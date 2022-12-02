#!/bin/bash
if [ $# -eq 0 ]; then
    echo "ERROR: Missing argument!"
    exit 1
fi
pacman -Rcns $1
