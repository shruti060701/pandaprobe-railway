#!/bin/sh
set -e

if [ -n "$API_URL" ]; then
  node -e "
    const fs = require('fs');
    const path = require('path');
    const target = 'http://localhost:8000';
    const replacement = process.env.API_URL;
    console.log('Replacing', target, 'with', replacement);

    function walk(dir) {
      let files = [];
      for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const full = path.join(dir, entry.name);
        if (entry.isDirectory()) files = files.concat(walk(full));
        else if (entry.name.endsWith('.js') || entry.name.endsWith('.json')) files.push(full);
      }
      return files;
    }

    let count = 0;
    for (const f of walk('/app/.next')) {
      const content = fs.readFileSync(f, 'utf8');
      if (content.includes(target)) {
        const updated = content.split(target).join(replacement);
        fs.writeFileSync(f, updated, 'utf8');
        count++;
        console.log('Replaced in:', f);
      }
    }
    console.log('Total files updated:', count);

    // Verify
    let remaining = 0;
    for (const f of walk('/app/.next')) {
      if (fs.readFileSync(f, 'utf8').includes(target)) {
        remaining++;
        console.log('STILL CONTAINS localhost:8000:', f);
      }
    }
    console.log(remaining ? 'WARNING: ' + remaining + ' files still contain localhost:8000' : 'VERIFIED: No localhost:8000 remaining');
  "
fi

exec node /app/server.js
