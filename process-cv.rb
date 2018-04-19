#! /usr/bin/env ruby
# Based on https://github.com/denten-bin/write-support

require 'yaml'

# Load in data sources & dump them to a new file.
data = {}
Dir.glob('data/*.yml') do |file|
  key = file.sub(/^data\//, "").sub(/\.yml$/, "")
  data[key] = YAML.load_file file
end
data["title"] = data["format"]["title"] # pandoc complains if no "title" is set.
File.open('metadata.yml', 'w') do |file|
  file.puts YAML::dump(data)
  file.puts "date: #{Time.now.strftime "%F"}" # set the date
  file.puts "---" # pandoc needs the trailing marker to understand the yaml is done
end

# Set the templates
if data["format"]["mode"] == "markdown"
  tex_template = "templates/tex.tex"
  html_template = "templates/html.html"
else
  raise "Formatting mode must be 'markdown'."
end

# Make a list of the sections files.
files = data["format"]["cv-sections"].map{ |section| "sections/#{section}.md" }.join " "

# Prepare the output for tex, pdf, and html
output = [{
  template: tex_template,
  other_opts: "",
  file_name: "out.tex"
}, {
  template: tex_template,
  other_opts: "--pdf-engine=xelatex",
  file_name: "#{data["format"]["pdf-options"]["filename"]}.pdf"
}, {
  template: html_template,
  other_opts: "",
  file_name: "index.html"
}]

# Summon pandoc.
output.each do |format|
  command = "pandoc -sr markdown+yaml_metadata_block --template=#{format[:template]} #{format[:other_opts]} metadata.yml #{files} -o docs/#{format[:file_name]}"
  system command
  puts "Generated docs/#{format[:file_name]}"
end
