#!/bin/bash
set -e

# ---------- root SSH ----------
if [ -n "$ROOT_AUTHORIZED_KEY" ]; then
  echo "$ROOT_AUTHORIZED_KEY" > /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/authorized_keys
fi

if [ -n "$ROOT_PASSWORD" ]; then
  echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# ---------- rclone 配置 ----------
/scripts/gen_rclone_config.sh

# ---------- 从 R2 恢复（包含 Tailscale 状态） ----------
/scripts/restore.sh || echo "restore failed or skipped"

# ---------- 启动 supervisord ----------
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
