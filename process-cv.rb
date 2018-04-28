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
# Check to make sure the LaTeX fonts exist.
%w(regular italic monospace bold smallcaps).each do |font|
  if data["format"]["pdf-options"]["fonts"][font]
    if File.exist? "./fonts/#{data["format"]["pdf-options"]["fonts"][font]}.otf"
      puts "Found font ./fonts/#{data["format"]["pdf-options"]["fonts"][font]}.otf"
    else
      puts "Could not find ./fonts/#{data["format"]["pdf-options"]["fonts"][font]}.otf, defaulting to Computer Modern"
      data["format"]["pdf-options"]["fonts"][font] = nil
    end
  end
end
# set the headings style
if data["format"]["pdf-options"]["headings"] == "margin"
  puts "Headings in margin mode."
  data["format"]["pdf-options"]["margin-heading"] = true
end
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
  other_opts: "+raw_tex",
  file_name: "out.tex"
}, {
  template: tex_template,
  other_opts: "+raw_tex --pdf-engine=xelatex",
  file_name: "#{data["format"]["pdf-options"]["filename"]}.pdf"
}, {
  template: html_template,
  other_opts: "-raw_tex",
  file_name: "index.html"
}]

# Summon pandoc.
output.each do |format|
  command = "pandoc -sr markdown+yaml_metadata_block#{format[:other_opts]} --template=#{format[:template]} metadata.yml #{files} -o docs/#{format[:file_name]}"
  system command
  puts "Generated docs/#{format[:file_name]}"
end
