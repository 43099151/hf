#!/bin/bash
set -e

# root SSH key / password
if [ -n "${ROOT_AUTHORIZED_KEY:-}" ]; then
  echo "$ROOT_AUTHORIZED_KEY" > /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/authorized_keys
fi

if [ -n "${ROOT_PASSWORD:-}" ]; then
  echo "root:${ROOT_PASSWORD}" | chpasswd
fi

/scripts/gen_rclone_config.sh
/scripts/restore.sh || true

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
