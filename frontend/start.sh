#!/bin/sh
set -e

if [ -n "$API_URL" ]; then
  echo "Replacing API URL in Next.js build files..."
  FILES=$(grep -rl "localhost:8000" /app/.next/ 2>/dev/null || true)
  for f in $FILES; do
    echo "Replacing in: $f"
    sed -i "s|http://localhost:8000|$API_URL|g" "$f"
  done
  echo "Replacement complete. Files processed: $(echo "$FILES" | grep -c . || echo 0)"
fi

exec node /app/server.js
