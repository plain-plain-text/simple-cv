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

# 2. collapse data/yml files into one,
# get rid of ---,
# and add one --- back for the first line.
cat data/*.yml | sed '/^---/d' | sed '1s/^/---/' > tmp/metadata.yml

# 3. Set date and close YAML block.
echo date: `date +%F` >> tmp/metadata.yml
echo --- >> tmp/metadata.yml

# 4. Set templates

# 5. Check to make sure fonts exist

# 6. Make sections list

# 7. Invoke pandoc
