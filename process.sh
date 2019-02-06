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

# 2. collapse metadata/yml files into one and add a --- for the first line.
cat metadata/*.yml | sed $'1s/^/---\\\n/' > tmp/metadata.yml

# 3. Set date and close YAML block.
echo date: `date +%F` >> tmp/metadata.yml

# 4. Set templates
# This is a future feature that takes the `mode` key and sets
# the CV to markdown or yaml depending.

# 5. Set headings style
if grep -q "^\s*headings: margin" tmp/metadata.yml; then
  echo "margin-heading: true" >> tmp/metadata.yml
fi

# 6. Close metadata block.
echo --- >> tmp/metadata.yml

# 7. Make sections list
if [[ -f sections.txt ]]; then
  sections=`grep "^[^#]" sections.txt | sed -n 's#^\(.*\)$#sections/\1.md#p' | tr '\n' ' '`
else
  echo "Could not find file “sections.txt”"
  exit 1
fi

# 8. Grab filename.
if grep -q "^\s*filename:" tmp/metadata.yml; then
  pdf_filename=`grep "^\s*filename:" tmp/metadata.yml | awk -F ' ' '{print $2;}'`
else
  pdf_filename=CV
fi

# 9. Invoke pandoc
echo "Generating .tex, .pdf, and .html files."
pandoc -sr markdown+yaml_metadata_block+raw_tex \
  --template=templates/tex.tex \
  --metadata-file=tmp/metadata.yml \
  $sections \
  -o tmp/out.tex
echo .tex saved as tmp/out.tex
pandoc -sr markdown+yaml_metadata_block-raw_tex \
  --template=templates/html.html \
  --metadata-file=tmp/metadata.yml \
  $sections \
  -o docs/index.html
echo .html saved as docs/index.html
pandoc -sr markdown+yaml_metadata_block+raw_tex \
  --pdf-engine=xelatex \
  --template=templates/tex.tex \
  --metadata-file=tmp/metadata.yml \
  $sections \
  -o "docs/$pdf_filename.pdf"
echo .pdf saved as docs/"$pdf_filename".pdf
