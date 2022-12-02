#!/bin/bash
if [ $# -eq 0 ]; then
    echo "ERROR: Missing argument!"
    exit 1
fi
SCALING_GOVERNOR="$1"
cd /sys/devices/system/cpu/
echo $SCALING_GOVERNOR | tee cpu*/cpufreq/scaling_governor
