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

echo "Applying restored configurations..."

# 1. Supervisord
if [ -f /srv/conf/supervisor/supervisord.conf ]; then
    echo "Restoring supervisord.conf..."
    cp /srv/conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
fi

# 2. Nginx
if [ -d /srv/conf/nginx/conf.d ]; then
    echo "Restoring nginx configs..."
    cp -r /srv/conf/nginx/conf.d/* /etc/nginx/conf.d/ || true
fi
# if [ -d /srv/conf/nginx/sites-enabled ]; then
#     cp -r /srv/conf/nginx/sites-enabled/* /etc/nginx/sites-enabled/ || true
# fi

echo "Restore completed"
