# minecraft-scripts

A collection of helper scripts to manage your Minecraft server.

## Files

- `start_server.sh` — launch the server in a detached screen and auto-restart on crash.
- `backup_server.sh` — snapshot the entire `~/server` folder without overwriting previous backups.
- `backup_world.sh` — weekly rotating backup of the `world` subfolder.
- `scmd.sh` — send arbitrary commands into the running server screen.
- `LICENSE` — MIT license.

## Setup

1. Clone these scripts into `~/server/scripts/`.
2. Make them executable:
   ```bash
   chmod +x ~/server/scripts/*.sh
   ```
3. Install screen if you don’t have it:
    ```bash
    sudo apt update && sudo apt install screen
    ```
4. Run `start_server.sh` to get your server up:
    ```bash
    cd ~/server/scripts
    ./start_server.sh
    ```
5. Use `backup_server.sh` and `backup_world.sh` whenever you need backups; ideally via cron.

## Example Cron Jobs
```bash
# full backup daily at 3:30 AM
30 3 * * * /home/youruser/server/scripts/backup_server.sh

# world backup every Monday at 4 AM
0 4 * * 1 /home/youruser/server/scripts/backup_world.sh
```