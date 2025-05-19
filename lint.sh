#!/bin/bash
set -e

# PRのベースブランチを取得（GitHub Actionsの環境変数から）
BASE_BRANCH="${GITHUB_BASE_REF:-main}"  # Fallback to main if not set

echo "Fetching base branch: $BASE_BRANCH"
git fetch origin "$BASE_BRANCH"

# 差分ファイルを取得（ベースブランチとの差分）
changed_files=$(git diff --name-only "origin/$BASE_BRANCH"...HEAD -- '*.js' '*.jsx' '*.ts' '*.tsx')

if [ -z "$changed_files" ]; then
  echo "No JS/TS files changed. Skipping lint."
  exit 0
fi

echo "Running ESLint on changed files:"
echo "$changed_files"

# ESLint 実行
npx eslint $changed_files
