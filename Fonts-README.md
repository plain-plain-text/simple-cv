# Fonts in Simple-CV

Handling fonts in a LaTeX document like what ends up being the pdf version of
your CV can be complicated. Hopefully, you will just set the name of your font
in the right place in `data/pdf-options.yml`, and everything will work
correctly. However, it may be the case that XeLaTeX (what’s actually making
the pdf) cannot find your font. In that case, you have a few options:

1. In your shell, use the command `fc-list : family` to get a list of fonts
   that LaTeX seems to know about. This list is not authoritative, but it’s a
   good start. For example, if you don’t know what your specific version of
   Garamond is called, you can run `fc-list : family | grep -i "Garamond"`,
   which will print every font that matches “Garamond.” Note that if a font is
   listed twice on the same line, separated by a comma, the part before the
   comma is what you want.
2. Download or copy the font you want to use into this repository. For
   example:
  1. Go to [dafont](http://www.dafont.com) and download the font [Lemon
     Tuesday](https://www.dafont.com/lemon-tuesday.font?l[]=10&l[]=1), which
     is 100% free.
  2. Unzip the downloaded file and move the file `Lemon Tuesday.otf` into the
     same directory as this file.
  3. Edit line 10 of `data/pdf-options.yml` to read: `regular-font: Lemon
     Tuesday.otf`.
  4. Execute the shell script with `sh process.sh`
  5. The new pdf of the CV should be nearly unreadable, but it proves that
     changing the font worked.

For the purposes of a CV, I recommend using Georg Duffner’s free [EB
Garamond](https://bitbucket.org/georgd/eb-garamond/downloads/). If you
download and install EB Garamond, you can set line 10 of
`data/pdf-options.yml` to read: `regular-font: EB Garamond`.

If you need help installing fonts, Fontspring has a [tutorial for installing
fonts on Windows or Mac](https://www.fontspring.com/support/installing).

Once EB Garamond is installed, you can make use [its advanced OpenType
features](https://en.wikipedia.org/wiki/EB_Garamond#OpenType_Features) like
[swash](https://en.wikipedia.org/wiki/Swash_(typography)) features for italic
shapes or various ligature settings, like “historic” and “rare.” To learn more
about these various features and how to enable them in `templates/tex.tex`,
please see section IV of the [Fontspec
documentation](http://mirrors.ctan.org/macros/latex/contrib/fontspec/fontspec.pdf).
Here, for example, is the appropriate section of [my own
cv](http://cv.moacir.com/MPdSP-cv.pdf)’s template:

```tex
    \setmainfont{$regular-font$}[%
      $if(pdf-bold-as-smallcaps)$
        BoldFont = $regular-font$ ,
        BoldFeatures = {Letters=SmallCaps} ,
      $endif$
      Ligatures=Historic ,
      Ligatures=Rare ,
      ItalicFeatures={Style=Swash} ,
      Mapping=tex-text
    ]
```

Finally, the fonts may not work entirely as advertised in terms of producing
smallcaps or replacing bold with smallcaps. Again, adjusting the options sent
to Fontspec should help get precisely the look you want.
