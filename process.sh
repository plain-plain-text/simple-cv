#!/bin/sh
# Based on https://github.com/denten-bin/write-support

# This shell script processes the files in this repository to generate a few
# temporary files and a final pdf and html file for a CV.

# 1. reset tmp directory.
if [[ -d tmp ]]; then
  # The directory exists, so empty its contents
  rm tmp/*
else
  mkdir tmp
fi

# 2. collapse data/yml files into one and add a --- for the first line.
cat data/*.yml | sed '1s/^/---/' > tmp/metadata.yml

# 3. Set date and close YAML block.
echo date: `date +%F` >> tmp/metadata.yml
echo --- >> tmp/metadata.yml

# 4. Set templates
# This is a future feature that takes the `mode` key and sets
# the CV to markdown or yaml depending.

# 5. Check to make sure fonts exist
for fonttype in regular italic monospace bold smallcaps
do
  font=`grep "^\s*$fonttype:" tmp/metadata.yml | awk -F ' ' '{print $2;}'`
  if [[ ! -z "$font" ]]; then # $font is not empty.
    if [[ -f "fonts/$font.otf" ]]; then
      echo "Found font ./fonts/$font.otf"
    else
      echo "Could not find font ./fonts/$font.otf. Defaulting to Computer Modern."
    fi
  fi
done

# 5. Set headings style
# if grep -q "^\s*headings: margin" tmp/metadata.yml; then
# fi

# 6. Make sections list
if [[ -f sections.txt ]]; then
  sections=`grep "^[^#]" sections.txt | sed -n 's#^\(.*\)$#sections/\1.md#p' | tr '\n' ' '`
else
  echo "Could not find file “sections.txt”"
  exit 1
fi

# 7. Invoke pandoc
