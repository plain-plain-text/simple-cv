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

## Using

1. Clone the repository:

`git clone git@github.com:muziejus/simple-cv.git`

1. Enable GitHub pages on your new repository:
  * Click on the “Settings” on your repository’s GitHub page.
  * 

1. Edit `data.yml` to match your personal details

1. Edit the documents in `sections/` to match your own CV
