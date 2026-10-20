"""Template python package."""

from importlib.metadata import PackageNotFoundError, version

try:
    __version__ = version("template-python")
except PackageNotFoundError:  # not installed, e.g. run from a source tree
    __version__ = "0.0.0+unknown"
