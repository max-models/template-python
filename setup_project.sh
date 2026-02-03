#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <app-name>"
  exit 1
fi

APPNAME="$1"
APPNAME_UNDERSCORE="${APPNAME//-/_}"

# 1. Find and replace "testproject" with app name
grep -rl "testproject" . | while IFS= read -r file; do
  LC_ALL=C sed -i.bak "s/testproject/${APPNAME}/g" "$file"
  rm -f "${file}.bak"
done

# 2. Move src/app to src/<appname_with_underscores>
if [[ -d "src/app" ]]; then
  mv src/app "src/${APPNAME_UNDERSCORE}"
else
  echo "Error: src/app does not exist"
  exit 1
fi

# 3. Replace import in src/**/*.py
# from app.main import main -> from <appname_with_underscores>.main import main

find src -type f -name "*.py" -print0 | while IFS= read -r -d '' file; do
  LC_ALL=C sed -i.bak \
    "s/from app\.main import main/from ${APPNAME_UNDERSCORE}.main import main/g" \
    "$file"
  rm -f "${file}.bak"
done


echo "Done:"
echo "  Replaced 'testproject' → '${APPNAME}'"
echo "  Moved src/app → src/${APPNAME_UNDERSCORE}"
echo "  Replaced import statements in src/**/*.py"
echo "You can now remove this script with: rm setup_project.sh"
