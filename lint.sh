#!/bin/bash
set -e

# PRのベースブランチを取得
BASE_BRANCH="${GITHUB_BASE_REF:-main}"  # GITHUB_BASE_REF は pull_request のときだけ存在

echo "Base branch is: $BASE_BRANCH"

# originが存在しない・浅いクローンで履歴不足の可能性があるため、fetch強化
echo "Fetching full history..."
git fetch --no-tags --prune --unshallow || git fetch --all

echo "Fetching base branch from origin..."
git fetch origin "$BASE_BRANCH":"refs/remotes/origin/$BASE_BRANCH"

# 共通のマージベースが存在するか確認
echo "Checking for common ancestor with $BASE_BRANCH..."
if ! git merge-base --is-ancestor origin/"$BASE_BRANCH" HEAD; then
  echo "Error: No common ancestor found between HEAD and origin/$BASE_BRANCH"
  exit 1
fi


# 差分ファイルを取得
changed_files=$(git diff --name-only "origin/$BASE_BRANCH"...HEAD -- '*.js' '*.jsx' '*.ts' '*.tsx')

if [ -z "$changed_files" ]; then
  echo "No JS/TS files changed. Skipping lint."
  exit 0
fi

echo "Running ESLint on changed files:"
echo "$changed_files"

npx eslint $changed_files
