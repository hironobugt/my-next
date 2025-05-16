#!/bin/bash

set -e

echo "🔍 Linting changed TypeScript files..."

# Ensure full git history is available
git fetch --unshallow || true
git fetch origin "${GITHUB_BASE_REF}"



#if [ -z "$1" ]; then
  echo "No files provided. Linting everything."
  npx eslint .
else
  echo "Linting only changed files:"
  echo "$@"
  npx eslint "$@"
fi
