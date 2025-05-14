#!/bin/bash
set -e

echo "Running ESLint..."

# BASE_BRANCH を GITHUB_BASE_REF から取得。fallback は origin/main
BASE_BRANCH="${BASE_BRANCH:-origin/${GITHUB_BASE_REF:-main}}"

echo "Comparing with base branch: $BASE_BRANCH"

if [ "$1" == "--diff" ]; then
  echo "Linting only changed files..."
  
  git fetch origin "$BASE_BRANCH" || true

  FILES=$(git diff --name-only "$BASE_BRANCH"...HEAD | grep -E '\.(js|jsx|ts|tsx)$' || true)

  if [ -z "$FILES" ]; then
    echo "No relevant file changes to lint."
    exit 0
  fi

  echo "Files to lint:"
  echo "$FILES"

  npm install
  npx eslint $FILES
else
  npm install
  npx next lint
fi
