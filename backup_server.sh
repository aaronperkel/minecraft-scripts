#!/usr/bin/env bash
# backup_server.sh — snapshot the whole server (~/server) without overwriting past backups.

set -euo pipefail

# CONFIG
BACKUP_DIR="$HOME/backups"
SERVER_DIR="$HOME/server"
SCREEN_NAME="minecraftserver"

# send a command into the Minecraft screen session
server_command() {
  screen -S "$SCREEN_NAME" -p 0 -X stuff "$1$(printf \\r)"
}

# prepare
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d-%H%M)
TARGET_DIR="${BACKUP_DIR}/server_backup_${TIMESTAMP}"

# notify & save
server_command "say [Backup] starting…" 
server_command "say save-all flush"
sleep 5

# copy
cp -a "$SERVER_DIR" "$TARGET_DIR"

# notify done (no emojis)
server_command "say [Backup] finished! Saved to ${TARGET_DIR}"