#!/bin/bash
set -e

npm install

echo "Running ESLint..."

# 差分 lint の場合
if [ "$1" == "--diff" ]; then
  echo "Linting only changed files..."

  # GitHub Actions のブランチ名から base を取得（例: origin/main）
  BASE_BRANCH="${BASE_BRANCH:-origin/main}"

  # 差分に含まれる js/ts/tsx ファイルのみ抽出
  FILES=$(git diff --name-only "$BASE_BRANCH"...HEAD | grep -E '\.(js|jsx|ts|tsx)$' || true)

  if [ -z "$FILES" ]; then
    echo "No relevant file changes to lint."
    exit 0
  fi

  echo "Files to lint:"
  echo "$FILES"

  # Lint 実行
  npx eslint $FILES
else
  # 通常モード（全体に対して）
  npx next lint
fi
