#!/bin/bash
set -e

if [ ! -f lint-diff-files.txt ]; then
  echo "No lint-diff-files.txt found. Skipping lint."
  exit 0
fi

files=$(cat lint-diff-files.txt | tr '\n' ' ')
if [ -z "$files" ]; then
  echo "No files listed. Skipping lint."
  exit 0
fi

npm install

echo "Running ESLint on the following files:"
echo "$files"
npm run lint $files
