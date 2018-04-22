# simple-cv

This repository lets one write an academic CV using Markdown. Using the
discrete Markdown files and a bit of information provided by `YAML` files, it
generates a CV in both `html` and `pdf` forms. Furthermore, it even hosts them
on GitHub Pages. This project was inspired by my [own
cv](http://cv.moacir.com), which uses the same underlying logic.

Demo:
[http://muziejus.github.io/simple-cv/](http://muziejus.github.io/simple-cv/)

## Requirements/Assumptions

1. You have used the command line before. 

1. You know the basics of the [YAML
   syntax](https://learnxinyminutes.com/docs/yaml/).

1. [Pandoc](https://pandoc.org/). They have an [installing
   page](https://pandoc.org/installing.html) that explains the process for
   various computers. For Macs, you can simply do `brew install pandoc` if you
   have [Homebrew](http://brew.sh) installed, which you should.

1. A TeX engine of some sort. The folks at Pandoc [have recommendations and
   instructions](https://pandoc.org/installing.html) for different operating systems. 
   
## Installing

1. Clone the repository: `git clone git@github.com:muziejus/simple-cv.git`

1. Enable GitHub pages on your new repository:
  * Click on the “Settings” on your repository’s GitHub page.
  * Scroll down to “GitHub Pages” and choose “master branch /docs folder.”
  * Click “Save” beside that.

Now the sample webpage should be visible at
`http://GITHUBUSERNAME.github.io/simple-cv/`.

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
   managed by the two files in the `templates/` directory.

When you’ve made your changes, you must run the ruby script:

`ruby process-cv.rb`

This produces new versions of the `html` and `pdf` files, so you can
subsequently stage, commit, and push, to make the files available online.

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
* `address`: Whether to print the address as its own entity. I find this to be
  clumsy, so it’s set to false.
* `style`: Four mix and matchable options are available here, that determine
  how the headings are presented as well as the title.
* `smallcaps-headings`: Whether the headers and name are in small caps or not.
* `footer`: By default, a footer is added that includes the author(s) name(s)
  and the last modified date. One or both of those options can be suppressed.
* `fonts`: This lets you give the name of OpenType fonts for use in the
  document, but they must be in the `fonts/` directory. See `fonts/FONTS-README.md`
  for more details.

#### `html` options

* `headshot-url`: Some cultures expect a headshot in a CV. Here is where you
  tell Pandoc where to find it. Leaving it blank means no headshot.
* `lang`: The language code for the CV. Default is `en` because American hegemony.
* `fontawesome`: Whether to use the [Font Awesome](http://fontawesome.com)
  icons.
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
* `fonts`: Three separate font families are supported, one for the body text,
  one for the headings, and one for the navbar. If you only want one custom
  font throughout, set the `body` font and comment our `headings` and
  `navbar`. Each of `body`, `headings`, and `navbar` needs three options:
    * `type`: `serif`, `sans-serif`, or `monospace`. This is the fallback
      should the preferred font not load.
    * `url`: The URL for the font, like from
      [Google](http://fonts.google.com).
    * `name`: The name of the font for the CSS.
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

* BibTeX support
* Europass support
* font-wrangling support

