# simple-cv

This repository lets one create fill in a template of data that then creates a
CV in both `html` and `pdf` forms. Furthermore, it even hosts them on GitHub
Pages. This project was inspired by my [own cv](http://cv.moacir.com), which
uses the same underlying logic but has any amount of specialized fields coded
in.

## Requirements/Assumptions

1. You have used the command line before. 

1. [Pandoc](https://pandoc.org/). They have an [installing
   page](https://pandoc.org/installing.html) that explains the process for
   various computers. For Macs, you can simply do `brew install pandoc` if you
   have [Homebrew](http://brew.sh) installed, which you should.

1. A TeX engine of some sort. The folks at Pandoc have recommendations for
   different operating systems. If you want a
   [Europass](https://europass.cedefop.europa.eu/) CV, you will need to
   install the
   [EuropassCV](https://www.ctan.org/tex-archive/macros/latex/contrib/europasscv)
   package with `sudo tlmgr install europasscv`.

## Installing

1. Clone the repository: `git clone git@github.com:muziejus/simple-cv.git`

1. Enable GitHub pages on your new repository:
  * Click on the “Settings” on your repository’s GitHub page.
  * Scroll down to “GitHub Pages” and choose “master branch /docs folder.”
  * Click “Save” beside that.

Now the sample webpage should be visible at
`http://GITHUBUSERNAME.github.io/simple-civ/`.

## Editing 

There are three things to edit in this repository. 

1. The metadata, which is simple information about yourself and about the CV
   you want, is saved in the file `metadata.yml`

1. Each section of your CV (education, publications, etc.) is its own Markdown
   file in `sections/`.

1. The look and feel of both the `html` and `pdf` versions of the document are
   managed by the two files in the `templates/` directory.

When you’ve made your changes, you must run the ruby script:

`ruby process.rb`

This produces new versions of the `html` and `pdf` files, so you can
subsequently stage, commit, and push, to make the files available online.

## Features

## Metadata.yml

## Sections

## Rationale

Being able to update both my online and “paper” CV at once has been a goal for
over a decade. Luckily, Pandoc has stepped in to make that process simpler.
This project used to be a complicated and very brittle system using
MultiMarkDown and shell script. This all works, in my opinion, more simply.

## Features to Add

* BibTeX support
* Europass support
* font-wrangling support

