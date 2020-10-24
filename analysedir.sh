#!/bin/bash

rm -f $TMP_DIR/summary.tex

find $1 -type f -exec ./analyse.sh "{}" \;