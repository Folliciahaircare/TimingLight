#!/bin/bash
cd "$(dirname "$0")"
PORT=8123
HOST=127.0.0.1

PYTHON="$(command -v python3 || command -v python)"
if [ -z "$PYTHON" ]; then
  echo "Could not find python3 on this Mac."
  echo "You can still use the timer by double-clicking Timing Light.html directly —"
  echo "just the floating window feature may not work that way."
  read -p "Press Return to close this window..."
  exit 1
fi

open_in_chrome() {
  if [ -d "/Applications/Google Chrome.app" ]; then
    open -a "Google Chrome" "$1"
  else
    echo "Google Chrome wasn't found — opening in your default browser instead."
    open "$1"
  fi
}

if lsof -i ":$PORT" >/dev/null 2>&1; then
  echo "Port $PORT is already in use — Timing Light may already be running."
  echo "Opening it in your browser now."
  open_in_chrome "http://$HOST:$PORT/Timing%20Light.html"
  read -p "Press Return to close this window..."
  exit 0
fi

"$PYTHON" -m http.server "$PORT" --bind "$HOST" >/tmp/timing-light-server.log 2>&1 &
SERVER_PID=$!

READY=0
for i in $(seq 1 20); do
  if curl -s -o /dev/null "http://$HOST:$PORT/"; then
    READY=1
    break
  fi
  sleep 0.5
done

if [ "$READY" != "1" ]; then
  echo "The local server didn't start in time. Details:"
  cat /tmp/timing-light-server.log 2>/dev/null
  echo ""
  echo "You can still use the timer by double-clicking Timing Light.html directly —"
  echo "just the floating window feature may not work that way."
  read -p "Press Return to close this window..."
  kill "$SERVER_PID" 2>/dev/null
  exit 1
fi

open_in_chrome "http://$HOST:$PORT/Timing%20Light.html"
echo ""
echo "Timing Light is running at http://$HOST:$PORT"
echo "Keep this window open while you're using the timer."
echo "Close this window to stop it."
echo ""
wait "$SERVER_PID"
