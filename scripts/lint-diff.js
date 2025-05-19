// lint-diff.js
const { execSync } = require('child_process');
const fs = require('fs');

// 変更されたファイルのみを対象にした差分を取得
const changedFiles = execSync('git diff --name-only --diff-filter=ACMRTUXB HEAD').toString().split('\n').filter(Boolean);

// lint 実行結果を格納する変数
let lintResults = [];

// 変更されたファイルに対して lint を実行
changedFiles.forEach(file => {
  try {
    const result = execSync(`npx eslint ${file} --format=json`).toString();
    lintResults.push(...JSON.parse(result)); // 結果をJSONとして解析
  } catch (error) {
    // エラー（警告が出た場合）は無視して、差分として保存
    console.log(`Linting failed for ${file}: ${error.message}`);
  }
});

// lint 結果を CSV 形式で保存
const csvContent = lintResults.map(result => {
  return `"${result.filePath}","${result.messages.map(msg => msg.message).join('; ')}"`;
}).join('\n');

// ファイルに保存
fs.writeFileSync('lint-diff.csv', csvContent);
console.log('Lint diff written to lint-diff.csv');
