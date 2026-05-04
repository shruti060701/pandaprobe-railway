#!/bin/sh
set -e

if [ -n "$API_URL" ]; then
  echo "Searching for localhost:8000 in all JS files..."
  count=$(grep -rl "localhost:8000" /app/ 2>/dev/null | wc -l)
  echo "Found $count files containing localhost:8000"

  grep -rl "localhost:8000" /app/ 2>/dev/null | while read f; do
    echo "Replacing in: $f"
    sed -i "s|http://localhost:8000|$API_URL|g" "$f"
  done

  echo "Replacement complete."
fi

exec node /app/server.js
