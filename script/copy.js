const fs = require('fs');
const path = require('path');

// 源文件路径
const sourceFilePath = path.join(__dirname, 'assets');

// 目标文件路径
const targetFilePath = path.join(__dirname, 'public/assets');

// 复制文件
fs.copyFileSync(sourceFilePath, targetFilePath);