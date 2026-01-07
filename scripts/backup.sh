#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip backup"
  exit 0
fi

if [ -z "$R2_BUCKET" ]; then
  echo "R2_BUCKET not set, skip backup"
  exit 0
fi

echo "=== Backup to R2 ==="

# 核心数据
rclone sync /srv/conf r2:${R2_BUCKET}/conf
rclone sync /srv/data r2:${R2_BUCKET}/data
rclone sync /srv/www  r2:${R2_BUCKET}/www

# Tailscale 状态
rclone sync /var/lib/tailscale r2:${R2_BUCKET}/tailscale

# 系统配置
rclone sync /etc/nginx/sites-enabled r2:${R2_BUCKET}/nginx/sites-enabled
rclone sync /etc/php/*/fpm/pool.d r2:${R2_BUCKET}/php-fpm/pool.d
rclone sync /etc/ssh/sshd_config r2:${R2_BUCKET}/ssh/sshd_config
rclone sync /root/.ssh r2:${R2_BUCKET}/root-ssh
rclone sync /etc/supervisor/conf.d r2:${R2_BUCKET}/supervisor

echo "Backup completed"
