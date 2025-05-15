#!/bin/bash

set -e

# 差分ベースの取得（pull_request 環境で）
if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
  echo "Fetching base branch for diff..."
  git fetch origin "${GITHUB_BASE_REF}"

  CHANGED_FILES=$(git diff --name-only origin/"${GITHUB_BASE_REF}"...HEAD -- '*.ts' '*.tsx')
else
  echo "Non-PR event detected. Linting everything."
  CHANGED_FILES=$(git ls-files '*.ts' '*.tsx')
fi

if [ -z "$CHANGED_FILES" ]; then
  echo "No TypeScript files changed. Skipping lint."
  exit 0
fi

echo "Linting changed files:"
echo "$CHANGED_FILES"

npm install

npm run lint $CHANGED_FILES
