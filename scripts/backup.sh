#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip backup"
  exit 0
fi

PREFIX="${R2_PREFIX:-hf-vps}"

echo "=== Backup to r2:hf--backups/${PREFIX} ==="

rclone sync /srv/data "r2:hf--backups/${PREFIX}/data"
rclone sync /srv/conf "r2:hf--backups/${PREFIX}/conf"
rclone sync /srv/www  "r2:hf--backups/${PREFIX}/www"
rclone sync /var/lib/tailscale "r2:hf--backups/${PREFIX}/tailscale"

echo "Backup completed"
