#!/bin/bash

export TMP_DIR=${TMP_DIR:-$(mktemp -dt cardbackup-XXXXXXXX)}

rm -f $TMP_DIR/summary.tex

find $1 -type f -exec ./analyse.sh "{}" \;