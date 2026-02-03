# template-python

Template repository for python projects

Documentation: https://max-models.github.io/template-python/

# Install

Create and activate python environment

```
python -m venv env
source env/bin/activate
pip install --upgrade pip
```

Install the code and requirements with pip

```
pip install -e .
```

Run the code with

```
template-python
```

# Build docs


```
make html
cd ../
open docs/_build/html/index.html
```

# Publishing on PyPI

This project is configured to automatically publish to PyPI using GitHub Actions with trusted publishing (OIDC).

## Setup (One-time configuration)

### 1. Create PyPI Account and Project

1. Create an account on [PyPI](https://pypi.org/)
2. Create a new project or claim your project name

### 2. Configure Trusted Publishing on PyPI

1. Go to your PyPI project settings
2. Navigate to "Publishing" → "Add a new publisher"
3. Configure the trusted publisher with these details:
   - **PyPI Project Name**: `template-python` (or your project name)
   - **Owner**: Your GitHub username/organization
   - **Repository name**: `template-python`
   - **Workflow name**: `publish_pypi.yml`
   - **Environment name**: `pypi`

### 3. Configure GitHub Environment (Optional but Recommended)

1. Go to your GitHub repository → Settings → Environments
2. Create an environment named `pypi`
3. Add protection rules:
   - Deployment branches: Only `main` branch

## Publishing Process

Once configured, publishing is automatic:

1. **Merge to main branch**: Any push to the `main` branch triggers the workflow
2. **Automatic build**: The workflow builds the Python package
3. **Automatic publish**: The package is automatically published to PyPI using trusted publishing
