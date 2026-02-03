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

echo "Done:"
echo "  Replaced 'testproject' → '${APPNAME}'"
echo "  Moved src/app → src/${APPNAME_UNDERSCORE}"
