#!/bin/bash
set -e

# Replace hardcoded localhost:8000 with the actual backend URL
if [ -n "$API_URL" ]; then
  echo "Replacing localhost:8000 with $API_URL in Next.js build..."
  find /app/.next -type f -name "*.js" -exec sed -i "s|http://localhost:8000|$API_URL|g" {} + 2>/dev/null || true
  find /app/.next -type f -name "*.json" -exec sed -i "s|http://localhost:8000|$API_URL|g" {} + 2>/dev/null || true
  echo "Done."
fi

# Start Next.js
exec node server.js
