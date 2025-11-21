## Project Overview

This is a personal blog and "Today I Learned" (TIL) website built with Jekyll and hosted on GitHub Pages. The site is owned by Anton Kuzmenko.

The project uses a standard Jekyll structure:
- `_config.yml`: Main configuration file.
- `_posts/`: Contains blog posts.
- `_layouts/`: Defines the structure of pages.
- `css/`: Custom stylesheets.
- `index.html`: The main entry point and homepage layout.

The content is written in Markdown and organized into two types of posts, as defined in `_config.yml`:
- Regular blog posts under `_posts/long/`.
- "TIL" (Today I Learned) posts under `_posts/tils/`, which are identified by the `til: true` front matter.

## Development Conventions

- Creating a new post:
  1. Create a new Markdown file in the appropriate subdirectory of `_posts/`.
  2. The filename must follow the Jekyll convention: `YYYY-MM-DD-title-of-the-post.md`.
  3. Add the necessary front matter at the top of the file. For example:
     ```yaml
     ---
     title: "My New Blog Post"
     date: YYYY-MM-DD
     tags: [tag1, tag2]
     published: true
     ---
     ```
- Front Matter:
  - `title`: The title of the post.
  - `date`: The publication date.
  - `tags`: An array of tags for the post.
  - `published`: Set to `true` to publish the post.
  - `til`: Set to `true` for TIL posts. This is automatically applied based on the directory (`_posts/tils/`).

## Deployment

The site is automatically deployed to GitHub Pages on every push to the `main` branch. The deployment process is defined in the `.github/workflows/jekyll.yml` file.
