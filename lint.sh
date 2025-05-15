#!/bin/bash

set -e

echo "🔍 Linting changed TypeScript files..."

# Ensure full git history is available
git fetch --unshallow || true
git fetch origin "${GITHUB_BASE_REF}"

# Get changed files
CHANGED_FILES=$(git diff --name-only origin/"${GITHUB_BASE_REF}"...HEAD -- '*.ts' '*.tsx')

if [ -z "$CHANGED_FILES" ]; then
  echo "✅ No relevant files changed."
  exit 0
fi

echo "🎯 Linting the following files:"
echo "$CHANGED_FILES"

npx eslint $CHANGED_FILES
