---
title: Publishing
description: Publish the package to PyPI and the documentation to GitHub Pages.
---

## Documentation

The `Docs` workflow builds the site on every push and pull request to `main` and `devel`. It
executes the tutorials, generates the API reference and uploads the site. Pushes to `main`
also deploy it to GitHub Pages at https://max-models.github.io/template-python/.

Enable GitHub Pages once in the repository settings, with "GitHub Actions" as the source.

## PyPI

The project is configured to publish to PyPI with GitHub Actions and trusted publishing (OIDC).

### One-time configuration

1. Create an account on [PyPI](https://pypi.org/) and create or claim your project name.
2. In the PyPI project settings go to "Publishing" → "Add a new publisher" and fill in:
   - **PyPI project name**: `template-python` (or your project name)
   - **Owner**: your GitHub username or organization
   - **Repository name**: `template-python`
   - **Workflow name**: `publish_pypi.yml`
   - **Environment name**: `pypi`
3. Optionally, in the GitHub repository settings create an environment named `pypi` whose
   deployment branches are limited to `main`.

### Publishing process

Any push to `main` triggers the workflow, which builds the package and publishes it to PyPI.
