#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip restore"
  exit 0
fi

PREFIX="${R2_PREFIX:-hf-vps}"

echo "=== Restoring core data from r2:hf--backups/${PREFIX} ==="

rclone sync "r2:hf--backups/${PREFIX}/data" /srv/data || true
rclone sync "r2:hf--backups/${PREFIX}/conf" /srv/conf || true
rclone sync "r2:hf--backups/${PREFIX}/www" /srv/www || true
rclone sync "r2:hf--backups/${PREFIX}/tailscale" /var/lib/tailscale || true

echo "Restore completed"
