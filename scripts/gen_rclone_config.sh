#!/bin/bash
set -e

RCLONE_CONF_DIR="/root/.config/rclone"
RCLONE_CONF_FILE="${RCLONE_CONF_DIR}/rclone.conf"

mkdir -p "$RCLONE_CONF_DIR"

if [ -z "${R2_ACCESS_KEY:-}" ] || [ -z "${R2_SECRET_KEY:-}" ] || [ -z "${R2_ACCOUNT_ID:-}" ] || [ -z "${R2_BUCKET:-}" ]; then
  echo "R2 env not fully set, skip rclone config"
  exit 0
fi

cat > "$RCLONE_CONF_FILE" <<EOF
[r2]
type = s3
provider = Other
access_key_id = ${R2_ACCESS_KEY}
secret_access_key = ${R2_SECRET_KEY}
endpoint = https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com
acl = private
EOF

echo "rclone config generated"
