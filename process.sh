#!/bin/sh
# Based on https://github.com/denten-bin/write-support

# This shell script processes the files in this repository to generate a few temporary files and a final pdf and html file for a CV.

# 1. reset tmp directory.
if [[ -d tmp ]]; then
  # The directory exists, so empty its contents
  rm tmp/*
else
  mkdir tmp
fi

# 2. collapse data/yml files into one & get rid of ---
cat data/*.yml | sed '/^---/d' > tmp/metadata.yml
