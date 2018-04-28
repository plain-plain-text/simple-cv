# simple-cv

This repository lets one write an academic CV using Markdown. With the
discrete Markdown files and a bit of information provided by `YAML` files, it
generates a CV in both `html` and `pdf` forms that have similar content.
Furthermore, it even allows you to host them on GitHub Pages. This project was
inspired by my [own cv](http://cv.moacir.com), which uses the same underlying
logic.

Demos:

* [http://muziejus.github.io/simple-cv/](http://muziejus.github.io/simple-cv/)
* [http://muziejus.github.io/simple-cv/H_W_Jones.pdf](http://muziejus.github.io/simple-cv/H_W_Jones.pdf)

## Requirements/Assumptions

1. You have used the command line before. The creation of the `html` and `pdf`
   files is done with a Ruby script you run from the command line.

1. You generally know what Git is and how to stage, commit, and push.

1. You know the basics of the [YAML
   syntax](https://learnxinyminutes.com/docs/yaml/). The repository as it
   exists here has examples of all the features in it, but it’s useful to know
   what YAML is, at least.

1. [Pandoc](https://pandoc.org/) installed. The Pandoc peopl have an
   [installation
   page](https://pandoc.org/installing.html) that explains the process for
   various systems. For Macs, you can simply do `brew install pandoc` if you
   have [Homebrew](http://brew.sh) installed, which you should.

1. A TeX engine of some sort. The folks at Pandoc [have recommendations and
   instructions](https://pandoc.org/installing.html) for different operating systems.

## Installing

1. Fork this repository by clicking on the “Fork” link at the top of this
   page.

1. In your new, forked repository, enable GitHub pages:
  * Click on the “Settings” on your repository’s GitHub page.
  * Scroll down to “GitHub Pages” and choose “master branch /docs folder.”
  * Click “Save” beside that.

    Now the sample CV should be visible at `http://GITHUBUSERNAME.github.io/simple-cv/`.

1. Your forked repository should now be cloned to your computer. GitHub
   [provides extensive
   instructions](https://help.github.com/articles/fork-a-repo/), but your own
   method may vary. If you use Atom as your text editor (which is a good
   choice, especially for beginners), you can follow [the instructions I wrote
   for my JavaScript students on linking Atom to a GitHub
   repository](https://the-javascripting-english-major.org/1-environment#s-link-atom-to-github),
   but you should note that the url you want to use is
   `https://github.com/GITHUBUSERNAME/simple-cv.git`.

1. Once the repository is forked to your GitHub account and cloned to your
   computer, you can start editing the YAML files in `data/` and the Markdown
   files in `sections/` as indicated below.

## Editing

There are three things to edit in this repository.

1. The data, which is simple information about yourself and about the CV
   you want, which is distributed among the `YAML` files saved in `data/`.

1. Each section of your CV (education, publications, etc.) is its own Markdown
   file in `sections/`. **Note:** The processing script does not know about
   these files, so you need to inform the script about them under
   `cv-sections` in `data/format.yml`. This allows you to determine the order
   of the sections on the fly.

1. The look and feel of both the `html` and `pdf` versions of the document are
   managed by the two files in the `templates/` directory. The [Pandoc
   templating language](https://pandoc.org/MANUAL.html#templates) is pretty
   straightforward, and the templates reveal how the data in `data/` is
   incorporated into the templates. That said, just because the templating
   language is easy doesn’t mean the templates are. The `html` file depends on
   the [Bootstrap](http://getbootstrap.com) framework, and the `pdf` file
   depends on the rather expansive [`memoir` LaTeX
   package](https://ctan.org/pkg/memoir?lang=en). I have tried to make the
   defaults acceptable, aesthetically, but I leave fine tuning up to you.

When you’ve made your changes, you must run the Ruby script in command line:

`ruby process-cv.rb`

If you have the [`run-command`](https://atom.io/packages/run-command) package installed in Atom, you can simply type `ctrl-r` and type in `ruby process-cv.rb` in the little dialog box to process the files without the need of opening the command line or leaving Atom.

The Ruby script produces new versions of the `html` and `pdf` files, so you can
subsequently stage, commit, and push, to make the files available online via
GitHub.

## Features

* Single source for both paper and web versions of your cv.
* Customizable sections that can be switched in and out or reordered just by
  changing a `YAML` option.
* Customizable styles for `html` *and* `pdf` (fonts, etc.) via `YAML` configuration files.
* Straightforward templates that allow for massive flexibility with
  comparatively little effort.
* Agnostic taxonomy of sections. If you don’t want to include your
  publications, say, don’t.
* Responsive `html` page with dynamically generated navbar provided by
  [Bootstrap](http://getbootstrap.com).
* URL support for digital projects, etc., in the `pdf`, meaning readers can
  click on the `pdf` to open websites.

## `data/` `YAML` files.

### `format.yml`

This document holds all the configuration options for formatting both
documents as well as the `html` and `pdf` versions on their own. These options
become variables like `$format.title$` in the templates. The templates use
[Pandoc’s templating language](https://pandoc.org/MANUAL.html#templates),
which allows for, crucially, iteration and conditionals. The options are split
up into three groups:

#### General options

These are mandatory:

* `title` this sets the `<title>` tag for the webpage and the metadata title
  for the pdf.
* `author`: This can be a collection or a single value of the author’s name.
* `mode`: For the time being, this must be set to `markdown`.
* `cv-sections`: This `YAML` collection stands in as the list of sections to
  the CV. Every section is its own Markdown page in the `sections/` directory.
  The order in which they are listed here is the order in which they appear in
  the final documents

#### `pdf` options

These options alert the `pdf` template to make certain decisions in building
the document

* `filename`: The name of the resulting `pdf` document (which is linked to
  from the `html` page as well).
* `footer`: By default, a footer is added that includes the author(s) name(s)
  and the last modified date. One or both of those options can be suppressed.
* `fonts`: This lets you give the name of OpenType fonts for use in the
  document, but they must be in the `fonts/` directory. See `fonts/FONTS-README.md`
  for more details.
* `headings`: One of two settings for the section headings. The
  default is `overlapped`, which creates headings that jut out to the left a
  bit in comparison to the body. The only other option is `margin`, which
  places the headings in their own boxes in the margin to create a nice
  effect.
* `smallcaps-headings`: Whether the headers and name are in small caps or not.
* `papersize`: Letter paper (8.5in x 11in) is the default, but any page size
  LaTeX understands works. `a4` is the only other size I can imagine using for a CV…
* `typesize`: How large the default text should be. The headings, etc., are
  all scaled in relation to this setting.
* `left-margin`: The left margin. Can be set in inches, centimeters,
  whatever. In the absence of a `right-margin`, it stands in for both
  horizontal margins.
* `right-margin`: The right margin. Only needed if it’s different from the
  left margin.
* `top-margin`: Should be a minimum of about .5in so that there is room at
  the bottom for the footer.
* `bottom-margin`: Unneeded unless the margin is different from the top
  margin. If this margin is large enough for the footer (.5in or so), then
  the top-margin can be made hilariously small.
* `display-style`: I created a default look, called `line` that is based on
  the `resume` package. However, any `memoir` chapter style, as demonstrated
  in [10.5 of the Memoir
  manual](http://texdoc.net/texmf-dist/doc/latex/memoir/memman.pdf) can be
  used here. Reasonable values include: `bianchi`, `bringhurst`, `chappell`,
 `crosshead`, `demo2`, `dowding`, `lyhne`, and `wilsondob`. Some of these styles will
  clobber your font choices.

#### `html` options

* `headshot-url`: Some cultures expect a headshot in a CV. Here is where you
  tell Pandoc where to find it. Leaving it blank means no headshot.
* `lang`: The language code for the CV. Default is `en` because American hegemony.
* `fontawesome`: Whether to use the [Font Awesome](http://fontawesome.com)
  icons.
* `background-color`: *Enclosed in "*, this is color recognizable by CSS, so, typically, either a hex value (“`#nnnnnn`”), an rgb value (“`rgb(n, n, n)`”), or an
  rgba value if you want to change the opacity (“`rgba(n, n, n)`”). See [this
  color picker](https://www.w3schools.com/colors/colors_picker.asp) provided
  by W3Schools to handcraft your color choice.
* `navbar`: A set of settings regarding the navbar that is added by default.
  * `background`: This option, set to `light` by default, corresponds to Bootstrap’s [semantic background
    colors](https://getbootstrap.com/docs/4.1/utilities/colors/#background-color)
  * `text`: `light` or `dark`, this corresponds to the background, so it’s a
    bit counter intuitive. That is, pick `light` if your background is light
    (though the text will be dark) and vice versa.
  * `position`: By default, the navbar scrolls with the rest of the CV. The
    other options, `fixed-top` and `fixed-bottom`, change that behavior. The
    most correct one to use is `sticky-top`, but that is not fully supported
    in all browsers yet.
  * `margin`: If the navbar is fixed, then we need to push the content away
    from it to provide some padding. Here you can tell it how many pixels to
    push it away. Default is 20.
  * `background-color`: This overrides the selection made for the navbar
    `background` above. See `background-color` above for information about
    picking colors.
* `fonts`: Three separate font families are supported, one for the body text,
  one for the headings, and one for the navbar. If you only want one custom
  font throughout, set the `body` font and comment our `headings` and
  `navbar`. Each of `body`, `headings`, and `navbar` needs three options:
    * `type`: `serif`, `sans-serif`, or `monospace`. This is the fallback
      should the preferred font not load.
    * `url`: The URL for the font, like from
      [Google](http://fonts.google.com).
    * `name`: The name of the font for the CSS.
    * `colors`: These allow adjusting the color values of the text. See
      `background-color` above for information about picking colors. Each
      color value must be enclosed in quotes. These are *optional*.
      * `body`: The color of the main body text.
      * `headings`: The color of the headings.
      * `display`: The color of the display name.
      * `navbar-items`: The color of the items in the navbar.
      * `links`: These adjust the colors of links.
        * `regular`: The color of the link text under regular circumstances.
        * `hover`: The color of the link text when the mouse or finger hovers
          over it.
* `keywords`: A list of keywords for SEO like this even works.
* `last-modified`: As with the `pdf`, this triggers a “last modified” widget
  to appear at the top right corner of the page.

### personal.yml

## Sections

The sections are all separate Markdown files in the `sections/` directory.
They can be called whatever, but the file names must correspond with the
`cv-sections` collection in `data/format.yml`.

Each section should begin with a `## Header`. Failure to do so will cause
problems in both the `html` and `pdf` versions of the CV. The text of the
header can be whatever.

The Markdown files can then be written however you want. A list, a narrative,
things with links, whatever is expected in your field and aligned with your
fantasies.

## Rationale

Being able to update both my online and “paper” CV at once has been a goal for
over a decade. Luckily, Pandoc has stepped in to make that process simpler.
This project used to be a complicated and very brittle system using
MultiMarkDown and shell script. This all works, in my opinion, more simply.

## Features to Add

* YAML mode that gets rid of Markdown completely
* BibTeX support
* Europass support
* Sass integration with Bootstrap.
