#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <app-name>"
  exit 1
fi

APPNAME="$1"
APPNAME_UNDERSCORE="${APPNAME//-/_}"

# 1. Find and replace "template-python" with app name
grep -rl "template-python" . --exclude-dir=.git --exclude-dir=docs/build | while IFS= read -r file; do
  LC_ALL=C sed -i.bak "s/template-python/${APPNAME}/g" "$file"
  rm -f "${file}.bak"
done

# Also replace template_python with appname_underscore
grep -rl "template_python" . --exclude-dir=.git --exclude-dir=docs/build | while IFS= read -r file; do
  LC_ALL=C sed -i.bak "s/template_python/${APPNAME_UNDERSCORE}/g" "$file"
  rm -f "${file}.bak"
done

# 2. Move src/app to src/<appname_with_underscores>
if [[ -d "src/app" ]]; then
  mv src/app "src/${APPNAME_UNDERSCORE}"
else
  echo "Error: src/app does not exist"
  exit 1
fi

# 3. Replace import in src/**/*.py and entry points
# from app.main import main -> from <appname_with_underscores>.main import main
# Also replace "app.main:main" -> "<appname_with_underscores>.main:main" in pyproject.toml

find src -type f -name "*.py" -print0 | while IFS= read -r -d '' file; do
  LC_ALL=C sed -i.bak \
    "s/from app\.main import main/from ${APPNAME_UNDERSCORE}.main import main/g" \
    "$file"
  rm -f "${file}.bak"
done

# Replace app.main:main entry point in pyproject.toml
if [[ -f "pyproject.toml" ]]; then
  LC_ALL=C sed -i.bak "s/app\.main:main/${APPNAME_UNDERSCORE}.main:main/g" "pyproject.toml"
  rm -f "pyproject.toml.bak"
fi

# 4. Remove the test_setup_script.yml workflow since it's no longer needed
if [[ -f ".github/workflows/test_setup_script.yml" ]]; then
  rm -f ".github/workflows/test_setup_script.yml"
fi


echo "Done:"
echo "  Replaced 'template-python' → '${APPNAME}'"
echo "  Replaced 'template_python' → '${APPNAME_UNDERSCORE}'"
echo "  Moved src/app → src/${APPNAME_UNDERSCORE}"
echo "  Replaced import statements and entry points"
echo "  Removed .github/workflows/test_setup_script.yml"
echo "You can now remove this script with: rm setup_project.sh"
