#!/bin/sh
# Based on https://github.com/denten-bin/write-support

# This shell script processes the files in this repository to generate a few temporary files and a final pdf and html file for a CV.
TEMPDIR="tmp"

# 1. reset tmp directory.
if [[ -d "$TEMPDIR" ]]; then
  # The directory exists, so empty its contents
  rm "$TEMPDIR"/*
else
  mkdir "$TEMPDIR"
fi
