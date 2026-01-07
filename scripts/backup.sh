#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip backup"
  exit 0
fi

echo "=== Backup to R2 ==="
rclone sync /srv/data r2:${R2_BUCKET}/data
rclone sync /srv/conf r2:${R2_BUCKET}/conf
rclone sync /srv/www  r2:${R2_BUCKET}/www
rclone sync /var/lib/tailscale r2:${R2_BUCKET}/tailscale
echo "Backup completed"
