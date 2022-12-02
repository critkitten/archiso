#!/bin/bash
watch -tn1 'cat /proc/cpuinfo | grep MHz | sort | sed 's/^...........//''
