#!/bin/bash
set -e

if ! rclone listremotes | grep -q "^r2:"; then
  echo "r2 remote not configured, skip restore"
  exit 0
fi

if [ -z "$R2_BUCKET" ]; then
  echo "R2_BUCKET not set, skip restore"
  exit 0
fi

echo "=== Restoring from R2 ==="
rclone sync r2:${R2_BUCKET}/conf /srv/conf || true
rclone sync r2:${R2_BUCKET}/data /srv/data || true
rclone sync r2:${R2_BUCKET}/www  /srv/www  || true
rclone sync r2:${R2_BUCKET}/tailscale /var/lib/tailscale || true

# 系统配置恢复
rclone sync r2:${R2_BUCKET}/nginx/sites-enabled /etc/nginx/sites-enabled || true
rclone sync r2:${R2_BUCKET}/php-fpm/pool.d /etc/php/*/fpm/pool.d || true
rclone sync r2:${R2_BUCKET}/ssh/sshd_config /etc/ssh/sshd_config || true
rclone sync r2:${R2_BUCKET}/root-ssh /root/.ssh || true
rclone sync r2:${R2_BUCKET}/supervisor /etc/supervisor/conf.d || true

# 修复权限
chmod 600 /root/.ssh/authorized_keys 2>/dev/null || true

echo "Restore completed"
