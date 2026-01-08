#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip backup"
  exit 0
fi

PREFIX="${R2_PREFIX:-hf-vps}"

echo "=== Backup to r2:hf--backups/${PREFIX} ==="

# 1. 备份关键配置到 /srv/conf (暂存区)
echo "Snapshoting configurations..."
mkdir -p /srv/conf/supervisor /srv/conf/nginx

# Supervisord
if [ -f /etc/supervisor/conf.d/supervisord.conf ]; then
    cp /etc/supervisor/conf.d/supervisord.conf /srv/conf/supervisor/supervisord.conf
fi

# Nginx
# 备份 conf.d 和 sites-enabled (如果用了 enabled 模式)
if [ -d /etc/nginx/conf.d ]; then
    rsync -av --delete /etc/nginx/conf.d/ /srv/conf/nginx/conf.d/
fi
# 如果你也用了 sites-enabled，可以把下面注释打开
# if [ -d /etc/nginx/sites-enabled ]; then
#     rsync -av --delete /etc/nginx/sites-enabled/ /srv/conf/nginx/sites-enabled/
# fi

echo "Config snapshot done."

rclone sync /srv/data "r2:hf--backups/${PREFIX}/data"
rclone sync /srv/conf "r2:hf--backups/${PREFIX}/conf"
rclone sync /srv/www  "r2:hf--backups/${PREFIX}/www"
rclone sync /var/lib/tailscale "r2:hf--backups/${PREFIX}/tailscale"

echo "Backup completed"
