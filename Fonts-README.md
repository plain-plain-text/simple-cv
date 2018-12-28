This folder is where you should drop any fonts you plan on using to generate
your pdf, as it’s the default location where the LaTeX template will look for
the explicit font files.

In the `data/format.yml` from the repository, you can see that the system
assumes that this folder has three fonts in it. Two are from Georg Duffner’s
[EB Garamond](https://bitbucket.org/georgd/eb-garamond/downloads/) project,
which is free for download. One is from Adobe, and it is also [free for
download](https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it).
The three files are:

* EBGaramond12-Regular.otf
* EBGaramond12-Italic.otf
* SourceCodePro-Regular.otf

The ruby processing script will work around not having these files in `fonts/`
and default to Computer Modern, but if you want to recreate a pdf that looks
exactly like [the demo
pdf](http://muziejus.github.io/simple-cv/H_W_Jones.pdf), you will need to put
these files in this project’s `fonts/` folder.

EB Garamond does not have a bold face yet, so `templates/tex.tex` never calls
on making something bold. If you would like to change that, you can’t use EB
Garamond and you’re on your own. Similarly, though the monospace font is
called above, it’s never actually used in the template; this is preparing for
future versions.
