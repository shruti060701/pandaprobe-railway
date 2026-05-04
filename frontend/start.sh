#!/bin/sh
set -e

if [ -n "$API_URL" ]; then
  echo "=== DEBUG: Searching for localhost patterns ==="
  echo "--- Files with 'localhost:8000' ---"
  grep -rl "localhost:8000" /app/.next/ 2>/dev/null || echo "NONE FOUND"
  echo "--- Files with 'localhost' (broader) ---"
  grep -rl "localhost" /app/.next/ 2>/dev/null | head -20 || echo "NONE FOUND"
  echo "--- Checking for gzipped static files ---"
  ls /app/.next/static/chunks/*.gz 2>/dev/null | head -5 || echo "NO GZ FILES"
  echo "--- Sample of matching content ---"
  grep -r "localhost:8000" /app/.next/ 2>/dev/null | head -5 || echo "NO MATCHES"
  echo "=== Replacing ==="

  for f in $(grep -rl "localhost:8000" /app/.next/ 2>/dev/null); do
    echo "Replacing in: $f"
    sed -i "s|http://localhost:8000|$API_URL|g" "$f"
  done

  echo "=== VERIFY: Any localhost:8000 remaining? ==="
  grep -r "localhost:8000" /app/.next/ 2>/dev/null | head -5 || echo "NONE - replacement successful"
fi

exec node /app/server.js
