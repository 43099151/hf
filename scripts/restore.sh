#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip restore"
  exit 0
fi

echo "=== Restoring core data ==="
rclone sync r2:${R2_BUCKET}/data /srv/data || true
rclone sync r2:${R2_BUCKET}/conf /srv/conf || true
rclone sync r2:${R2_BUCKET}/www  /srv/www  || true
rclone sync r2:${R2_BUCKET}/tailscale /var/lib/tailscale || true
echo "Core restore completed (system configs use image defaults)"
