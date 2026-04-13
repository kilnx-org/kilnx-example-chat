#!/bin/bash
# start.sh - Start Kilnx Chat with demo data
#
# Usage:
#   ./start.sh           # Start on default port 8080
#   PORT=3000 ./start.sh # Start on custom port
#
# On first run, seeds the database with 15 demo users and sample conversations.
# Demo login: alice@xpto.dev / demo123

set -e

PORT="${PORT:-8080}"
DB="chat.db"

# Start the server in background
kilnx run app.kilnx &
SERVER_PID=$!

# Trap Ctrl+C to kill server cleanly
trap "kill $SERVER_PID 2>/dev/null; exit 0" INT TERM

# Wait for DB to be created by the server (up to 10s)
echo "Starting server..."
for i in $(seq 1 20); do
  if [ -f "$DB" ]; then
    break
  fi
  sleep 0.5
done

if [ ! -f "$DB" ]; then
  echo "Error: database not created after 10s"
  kill $SERVER_PID 2>/dev/null
  exit 1
fi

# Seed only if DB is empty (first run)
USER_COUNT=$(sqlite3 "$DB" "SELECT COUNT(*) FROM user;" 2>/dev/null || echo "0")
if [ "$USER_COUNT" = "0" ]; then
  echo "Seeding demo data..."
  bash seed.sh "$DB"
  echo ""
  echo "Ready at http://localhost:$PORT"
  echo "Login: alice@xpto.dev / demo123"
else
  echo "Ready at http://localhost:$PORT"
fi

# Keep server running
wait $SERVER_PID
