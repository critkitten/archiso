#!/bin/bash

for f in $(find . -mindepth 1 -maxdepth 1 -type d); do cd $f && git pull && cd ..; done
