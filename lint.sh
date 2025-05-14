#!/bin/bash

CHANGED_FILES=("$@")

echo "Running lint on changed files:"
printf '%s\n' "${CHANGED_FILES[@]}"

if [ ${#CHANGED_FILES[@]} -eq 0 ]; then
  echo "No changed files to lint."
  exit 0
fi

npm install

# 例: ESLint を変更ファイルに対して実行
npm lint "${CHANGED_FILES[@]}"
