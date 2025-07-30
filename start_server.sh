#!/usr/bin/env bash
# start_server.sh — launch & auto-restart your Minecraft server in a detached screen.

set -euo pipefail

LOG_FILE="$HOME/server/scripts/start_server.log"
RESTART_FLAG="$HOME/server/scripts/restart.txt"
SCREEN_NAME="minecraftserver"
SERVER_DIR="$HOME/server"
JAR="server.jar"
JAVA_HOME="/usr/lib/jvm/jdk-23.0.1"

export PATH="$JAVA_HOME/bin:$PATH"
exec > >(tee -a "$LOG_FILE") 2>&1

# ensure restart flag exists
echo "true" > "$RESTART_FLAG"

start_minecraft() {
  echo "[`date`] Starting server…" 
  screen -dmS "$SCREEN_NAME" bash -c "cd '$SERVER_DIR' && exec bash"
  sleep 2
  screen -S "$SCREEN_NAME" -p 0 -X stuff "java -Xms6G -Xmx6G -jar $JAR nogui$(printf \\r)"
}

# initial launch
start_minecraft

# monitor loop
while true; do
  sleep 60
  RUNNING=$(pgrep -f "java .*${JAR}" || true)
  WANT_RESTART=$(<"$RESTART_FLAG")

  if [[ -z "$RUNNING" && "$WANT_RESTART" == "true" ]]; then
    echo "[`date`] Detected crash — restarting…" 
    start_minecraft
  fi
done