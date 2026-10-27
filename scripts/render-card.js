const fs = require('fs');
const path = require('path');
const card = fs.readFileSync(process.argv[2], 'utf8');
const root = process.argv[3];
// Escape text before translating terminal colors into HTML.
const html = card.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
  .replace(/\x1b\[39m/g, '</span>')
  .replace(/\x1b\[90m/g, '<span class="color-90">')
  .replace(/\x1b\[38;5;(\d+)m/g, '<span class="color-$1">')
  .replace(/\x1b\[[0-9;]*m/g, '')
  .split('\n').map(line => line.replace(/[ \t]+$/, '')).filter(line => line.length).join('\n');
if (!html.includes('Martin Kapp') || !html.includes('Github:')) {
  throw new Error('CLI output does not contain the expected card');
}
const output = fs.readFileSync(path.join(root, '_top.md'), 'utf8') + html + '\n' +
  fs.readFileSync(path.join(root, '_bottom.md'), 'utf8');
fs.writeFileSync(path.join(root, 'index.md'), output);
