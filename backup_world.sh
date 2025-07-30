#!/usr/bin/env bash
# backup_world.sh — rotate a weekly backup of just the world folder (~/server/world).

set -euo pipefail

# CONFIG
BACKUP_DIR="$HOME/backups"
WORLD_DIR="$HOME/server/world"
SCREEN_NAME="minecraftserver"

# helper
server_command() {
  screen -S "$SCREEN_NAME" -p 0 -X stuff "$1$(printf \\r)"
}

# prepare
mkdir -p "$BACKUP_DIR"
DAY=$(date +%A)
TARGET="${BACKUP_DIR}/world_backup_${DAY}"

# notify & save
server_command "say [World Backup] starting…" 
server_command "say save-all flush"
sleep 5

# rotate
rm -rf "$TARGET"
cp -a "$WORLD_DIR" "$TARGET"

# notify done (no emojis)
server_command "say [World Backup] done! Saved to ${TARGET}"