# Changelog

All notable changes to this project are documented in this file and maintained manually. The
format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- `PyPI dependencies` workflow and `scripts/check_pypi_dependencies.py`: on every pull request to
  `main`, fail if a dependency is a direct reference (`name @ git+https://...`), is not on PyPI, or
  has a version range that no release satisfies, instead of failing the release after the merge.

## [0.1.0] - 2026-10-05

### Added

- Package layout with a console entry point and pytest tests.
- Astro + Starlight documentation site with executed tutorials and a generated API reference.
- GitHub Actions for tests, ruff, pyright, tutorials, documentation and PyPI publishing.
