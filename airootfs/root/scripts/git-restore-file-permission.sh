#!/bin/bash
git diff -p \
| grep -E '^(diff|old mode|new mode)' \
| sed -e 's/^old/NEW/;s/^new/old/;s/^NEW/new/' \
| git apply
