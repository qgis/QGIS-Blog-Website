# ✨ Contributing to QGIS-Blog-Website

Thank you for considering contributing to QGIS Blog Website!
We welcome contributions of all kinds, including new blog posts, bug fixes, feature requests,
documentation improvements, and more. Please follow the guidelines below to
ensure a smooth contribution process.

## Contributions guidelines

### Reporting issues

- We do not accept text in issues/comments that are LLM (AI) generated as part of our policy (please see the [Using AI](#-using-ai-large-language-models) section for more details).
- **This repository is only for the QGIS blog (blog.qgis.org)** and we would appreciate if you could only report issues that are related to this website here.
Any issue related to other websites (e.g qgis.org, plugins.qgis.org) or the QGIS Desktop should be reported to their respective repository.
- If you are considering to submit a PR directly, **we recommend opening an issue first** explaining the bug or the request. That way, it can be discussed before you spend the effort addressing it.
- We recommend reporting each issue under its respective category. When pressing the **New issue** button, please choose one of  `Show Errors`, `Website Bug Report`, `Development`, `Feature Request` category. Never use the `Blank issue` for any issue that is under these existing categories.
- We also recommend attaching any relevant details like screenshots, error logs, wireframe... that could help us have more context about the issue.
- When submitting an issue, you should be always responsive to any questions and concerns. If we do not get a timely response, we reserve the right to close the issue so that we can keep the list of in-play issues we have to deal with small.

### Submitting a pull request

When submitting a PR, we are expecting you take into consideration the following guidelines:

- We do not accept text in PR title/descriptions/comments that are LLM (AI) generated as part of our policy (please see the [Using AI](#-using-ai-large-language-models) section for more details).
- The PR should always include an open issue reference (e.g Fixes #1234) unless the changes have been already discussed and the full context is provided.
- Make small, atomic changes. Your changeset size should not exceed more than 300 lines of code.
- Any content, UI/UX changes must always have screenshots attached (desktop/mobile version). Screenshots are also very welcome on any other changes whenever possible.
- When submitting PR, you should be always responsive to any questions, comments and changes requests. As with open issues, we reserve the right to close PR's if we do not get needed feedback in a timely manner. We do this to keep the number of in-consideration PR's short and manageable.


### 🤖 Using 'AI' (Large Language Models)

If you follow the QGIS discussion lists, QEP's etc. you will see that the use of LLM's and QGIS' acceptance of this is still under discussion. We are not the LLM police and do not have any systematic way to check if you are using an LLM or not - we expect you to self declare your LLM usage in your PR comment. That said, we are not super enthusiastic about receiving LLM generated patches if we do not know and trust you, and suggest that if you are making your first contributions, do it the old fashioned way (using brains and brawn, not an LLM). If you are a regular contributor and we trust that that submissions you make are of a good quality, we will likely be more accepting of LLM based contributions.

**Code changes only:** As stated in our project policy in [QEP 408](https://github.com/qgis/QGIS-Enhancement-Proposals/blob/master/qep-408-ai-tool-policy.md), AI/LLM generated text content are not allowed in all QGIS GitHub repositories. This includes issues and PR titles, descriptions, comments... Only the source code changes is allowed to be generated with the help of AI/LLM.


![-----------------------------------------------------](./img/green-gradient.png)

## 🏃Before you start

This web site is a static site built using [Hugo](https://gohugo.io/).

![Hugo Logo](./img/hugo-logo.png) and using the [hugo bulma blocks theme](https://github.com/qgis/QGIS-Hugo-Website-Theme).


![-----------------------------------------------------](./img/green-gradient.png)

## 🛒 Getting the Code

```sh
git clone --recurse-submodules https://github.com/qgis/QGIS-Blog-Website.git
cd QGIS-Blog-Website
# To update the submodule
git submodule update --init --recursive
```

## 🧑💻 Development

### Using Nix

The development environment is using Nix flakes. Please visit <https://nixos.wiki/wiki/Flakes> for more details.

Start the Nix development environment by running:

```sh
nix develop # Add  --experimental-features 'nix-command flakes' if you haven't enable Nix flakes
hugo server
```

To build the website:

```sh
nix build .#packages.x86_64-linux # Add | cachix push QGIS-Blog-Website to push it to cachix
```


### Install Hugo Locally

First install hugo for your local machine:

**📝 Note:** we need to install the 'extended' hugo version which includes a SASS compiler. If you don't install the extended version you will get errors like this when compiling:

```sh
ERROR 2022/12/11 07:33:37 Rebuild failed: TOCSS: failed to transform 
"css/style.scss" (text/x-scss). Check your Hugo installation; you need 
the extended version to build SCSS/SASS.: this feature is not available 
in your current Hugo version, see https://goo.gl/YMrWcn for more information
```

You can find the extended version in the [releases page](https://github.com/gohugoio/hugo/releases).

![Download](./img/hugo-download.png)

#### 🐧 Linux

Download the deb above and then do

```sh
sudo dpkg -i hugo_extended_0.161.1_linux-amd64.deb
```

#### 🪟 Windows

[Follow these notes](https://gohugo.io/installation/windows/)

#### 🍏 macOS

[Follow these notes](https://gohugo.io/installation/macos/)


![-----------------------------------------------------](./img/green-gradient.png)

## ⚙️ Setting up VSCode

If you are using VSCode, I recommend the following extensions:

- Hugo Language and Syntax Support
- Color Highlight

Clone the repo:

```sh
git clone https://github.com/qgis/QGIS-Blog-Website.git
```

Run the site:

Press ```Ctl-Shift-D``` then choose the following runner:

'Run dev using locally installed Hugo'

the click the green triangle next to  the runner to start it.

Once the site is running, you can open it at:

<http://localhost:1313>

The site will automatically refresh any page you have open if you edit it and save your work. Magical eh?


![-----------------------------------------------------](./img/green-gradient.png)

## Content Harvesting

Sustaining member data and logos are harvested using the `fetch_feeds.py` script.
This script fetches the sustaining members list and logos from the changelog
website and saves them to `content/funders`.

**Note:** Any manual changes made to the files in `content/funders` will be overwritten by this script.

```bash
./fetch_feeds.py
```

This script is run nightly as a GitHub Action (see `.github/workflows/update-feeds.yml`).

### Content markup

The posts imported from WordPress have raw HTML bodies that use Bulma classes.
The migration is finished and the import tooling is gone, so these files are now
maintained by hand like any other content. Two rules keep them working.

**Do not change a post's `title`, `slug` or `date`.** The permalink is built from
them (`config.toml` sets `posts = "/:year/:month/:day/:slug/"`), so changing
any of them moves the page and breaks every link to it.

**Keep the old image URLs working.** Each post is a folder with its images next
to `index.md`. `static/wp-content/` holds symlinks to those images, so the old
`/wp-content/uploads/...` URLs still work. Do not delete them.

Images used by several posts stay in `static/wp-content/` and are referenced as
`/wp-content/uploads/...`. `layouts/partials/post-details.html` prefixes that
path with the base URL, which needs a quote, whitespace or comma immediately
before `/wp-content/`, so keep the quoting around it.

If you write HTML in a post, use Bulma classes: `table is-fullwidth is-striped
is-hoverable` inside a `table-container` for tables, `image is-16by9` with a
`has-ratio` iframe for video embeds, and `columns is-multiline` with
`column is-one-third` for image grids. Do not paste WordPress markup back in
(`wp-block-*`, `alignnone`, `size-large`, `wp-caption`); nothing styles those
classes, so they do nothing but add noise.


![-----------------------------------------------------](./img/green-gradient.png)

## 📝 Writing a Blog Post

Each blog post is a folder in `content/posts/` with an `index.md` (TOML front matter) and the post's images next to it, so images show up in the GitHub preview.

### Front matter reference

```toml
---
title: "Your Post Title"
date: "2026-04-17T10:00:00+00:00"
draft: false
authors: ["your-author-slug"]
categories: ["Release Announcements"]
tags: ["qgis", "release"]
featured_image: "featured.png"
---
```

| Field | Required | Notes |
|---|---|---|
| `title` | Yes | The post title |
| `date` | Yes | ISO 8601 date/time |
| `draft` | Yes | Set to `false` to publish |
| `authors` | Yes | Array of author slugs matching `content/authors/<slug>/` |
| `categories` | No | Array of category names |
| `tags` | No | Array of tag names |
| `featured_image` | No | Image file in the post folder |

### Creating an author

If you are a new author, create `content/authors/<your-slug>/_index.md`:

```toml
---
title: "your-slug"
display_name: "Your Full Name"
bio: "Short bio about you."
---
```

### Adding images

Put the images in the post folder:

```
content/posts/your-post-slug/
  index.md
  featured.png
  screenshot-1.png
```

Reference them by file name:

```markdown
![Alt text](screenshot-1.png)
```

Do not use `static/wp-content/`, it is reserved for the old WordPress image URLs.

### Naming and filing conventions

- Folder name: `content/posts/your-post-slug/` — use lowercase, hyphen-separated words matching the post title
- The URL will be `/:year/:month/:day/:slug/` (e.g. `/2026/04/17/your-post-slug/`)
- Optimise images before committing: `python scripts/resize_image.py`

### Example minimal post

```markdown
---
title: "QGIS 4.1 is Released"
date: "2026-06-01T09:00:00+00:00"
draft: false
authors: ["timlinux"]
categories: ["Release Announcements"]
featured_image: "featured.png"
---

We are pleased to announce QGIS 4.1!

![QGIS 4.1 screenshot](screenshot.png)

More details below...
```


![-----------------------------------------------------](./img/green-gradient.png)

## 📸 Optimising Images

Before committing images, either:
- Optimize them for the web (rescale and use WebP)
- run the resize script to convert to WebP and cap dimensions:

```bash
python scripts/resize_image.py content/posts/your-post-slug/
```


![-----------------------------------------------------](./img/green-gradient.png)

## Search Functionality

The search functionality uses both [FuseJS](https://fusejs.io/) and [MarkJS](https://markjs.io/).

The search functionality code is based on this [Blog Post](https://makewithhugo.com/add-search-to-a-hugo-site/) and [GitHub Gist](https://gist.github.com/eddiewebb/735feb48f50f0ddd65ae5606a1cb41ae) by [Eddie Webb](https://twitter.com/eddturtle).

Content folders need to be excluded from search, by making them [headless bundles](https://gohugo.io/content-management/page-bundles/#headless-bundle) - which we have done for the sustaining member and flagship user folders in content/. To make other content folders which are not rendered and included in search results, add an ```index.md``` file with the following content: ```headless = true```.


![-----------------------------------------------------](./img/green-gradient.png)

## Referencing URLs in templates\n\nThe site needs to work in production, where the links of the site are all below the root URL, and in staging, where the site is deployed to GitHub Pages in a subpath. To ensure both deployment strategies work, please use the following method of constructing URLs in templates:\n\n```html\n<a class=\"button is-primary\" href=\"{{ \"donate/\" | absURL }}\">\n```\n\nFor images referenced in **front matter** (e.g. `featured_image`), templates use `| strings.TrimPrefix \"/\" | absURL` to ensure the subpath is preserved on GitHub Pages.\n\n**Note:** We do not use a leading slash in `absURL` calls, only a trailing slash.


![-----------------------------------------------------](./img/green-gradient.png)

## Styles (SASS/CSS)

SASS for most components is stored in themes/qgis-website-theme/assets/sass/bulma/components/

Some common styles are places in themes/qgis-website-theme/assets/sass/style.sass - this file is compiled as hugo template, hence has access to config.toml variables and hugo macroses

Also some bulma theme overrides are placed in themes/qgis-website-theme/assets/css/custom.css


![-----------------------------------------------------](./img/green-gradient.png)

## 📁 File naming conventions

- Separate words in file names with hyphens e.g. windows-download.md
- Avoid abbreviations in the words of your files
- Write file names in lower case only
- No spaces in file names


![-----------------------------------------------------](./img/green-gradient.png)

## 💮 Changing the templates

| Page type       | Path                                     |
| --------------- | ---------------------------------------- |
| Landing Page    | themes/qgis/layouts/index.html           |
| Top Level Pages | themes/qgis/layouts/_default/single.html |


![-----------------------------------------------------](./img/green-gradient.png)

## 🏠 Editing the landing (home) page

The layout of the landing page is themes/qgis-website-theme/layouts/index.html: the main page has many diverse blocks, that are not used anywhere else, hence its content is mostly in the partials.

The `content/_index.md` contains the front matter of the page and the contents for the `feature` shortcodes. Just edit whatever you like there. The blocks shortcodes are described [here](https://github.com/qgis/QGIS-Blog-Website/blob/main/docs/shortcodes.md)


![-----------------------------------------------------](./img/green-gradient.png)

## 📃 Adding a top level page

### Create the content

Content pages are stored in the `content` folder. The top level documents there will be rendered with the top level page theming.

For example to add an about page, create `content/about.md`

The page will be accessible then at /about/

### 🖼️ Referencing Images and Media

Place images and media in `static/img`. Everything in `static` is referenced from the top level of the site e.g.  `static/img/foo.png` would be referenced in
markdown as `/img/foo.png`.


![-----------------------------------------------------](./img/green-gradient.png)

## 📦 Blocks Shortcodes

The site uses a number of shortcodes to create reusable blocks of content. These are defined in the `themes/qgis-website-theme/layouts/shortcodes/` folder.

The shortcodes with screenshots are described [here](https://github.com/qgis/QGIS-Blog-Website/blob/main/docs/shortcodes.md)

### Sidebar

Sidebar is implemented in `themes/qgis-website-theme/layouts/partials/sidebar.html`.

Items are retrieved from config.toml under `[menu]` section. `weight` parameter defines the order of the item.

To enable sidebar on the content page, use the following template:

```html
---
type: "page"
...
sidebar: true
---
{{< content-start  >}}

... add content here ...

{{< content-end  >}}
```

![-----------------------------------------------------](./img/green-gradient.png)
