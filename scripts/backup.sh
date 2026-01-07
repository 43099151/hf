#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip backup"
  exit 0
fi

PREFIX="${R2_PREFIX:-hf-vps}"

echo "=== Backup to r2:${R2_BUCKET}/${PREFIX} ==="

rclone sync /srv/data "r2:${R2_BUCKET}/${PREFIX}/data"
rclone sync /srv/conf "r2:${R2_BUCKET}/${PREFIX}/conf"
rclone sync /srv/www  "r2:${R2_BUCKET}/${PREFIX}/www"
rclone sync /var/lib/tailscale "r2:${R2_BUCKET}/${PREFIX}/tailscale"

echo "Backup completed"
