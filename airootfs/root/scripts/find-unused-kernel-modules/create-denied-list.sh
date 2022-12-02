#!/bin/bash
./module-status.sh | grep LOADED | sed 's/\s.*$//' | sed 's/^/install /' | sed 's/$/ \/bin\/true/' > denied-unloaded-modules.config
