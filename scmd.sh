#!/usr/bin/env bash
# scmd.sh — send any string as a command to the Minecraft screen.
# Usage: ./scmd.sh "say Hello, world!"

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <minecraft-server-command>"
  exit 1
fi

SCREEN_NAME="minecraftserver"
screen -S "$SCREEN_NAME" -p 0 -X stuff "$1$(printf \\r)"