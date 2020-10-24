#!/bin/bash

rm -f summary.tex

find $1 -type f -exec ./analyse.sh "{}" \;