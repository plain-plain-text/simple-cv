#! /usr/bin/env ruby
# Based on https://github.com/denten-bin/write-support

require 'yaml'

# Load in data sources & dump them to a new file.
data = {}
Dir.glob('data/*.yml') do |file|
  key = file.sub(/^data\//, "").sub(/\.yml$/, "")
  data[key] = YAML.load_file file
end
File.open('metadata.yml', 'w') do |file|
  file.puts YAML::dump(data)
  file.puts "---"
end

# Set the templates
if data["format"]["mode"] == "markdown"
  tex_template = "templates/tex.tex"
  html_template = "templates/html.html"
else
  raise "Formatting mode must be 'markdown'."
end

# Concatenate the sections
files = data["format"]["cv-sections"].map{ |section| "sections/#{section}.md" }.join " "

# Add templating information
# tex_opts = ""
# pdf_opts = "--pdf-engine=xelatex"
# html_opts = ""
tex_opts = "--template=#{tex_template} "
pdf_opts = "--pdf-engine=xelatex --template=#{tex_template} "
html_opts = "--template=#{html_template}"

metadata = "--metadata=title:'#{data["format"]["title"]}' --metadata=author:'#{data["format"]["author"]}' --metadata=date:'#{Time.now.strftime "%F"}'"

tex_cmd = "pandoc -sr markdown+yaml_metadata_block \
  #{tex_opts} \
  'metadata.yml' \
  #{files} \
  #{metadata} \
  -o docs/out.tex"
pdf_cmd = "pandoc -sr markdown+yaml_metadata_block \
  #{pdf_opts} \
  'metadata.yml' \
  #{files} \
  #{metadata} \
  -o docs/#{data["format"]["pdf-options"]["filename"]}.pdf"
html_cmd = "pandoc -sr markdown+yaml_metadata_block \
  #{html_opts} \
  'metadata.yml' \
  #{files} \
  #{metadata} \
  -o docs/index.html"

system tex_cmd
puts "Generated docs/out.tex"
system pdf_cmd
puts "Generated docs/#{data["format"]["pdf-options"]["filename"]}.pdf"
system html_cmd
puts "Generated docs/index.html"




