# VPS for Hugging Face Spaces with Tailscale + R2 Backup
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates curl wget vim git supervisor nginx php8.2-fpm php8.2-cli \
    php8.2-json php8.2-curl php8.2-mbstring php8.2-xml php8.2-zip openssh-server \
    rclone build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---------- 安装 Tailscale ----------
RUN curl -fsSL https://tailscale.com/install.sh | sh

# ---------- 安装轻量 SOCKS5：microsocks ----------
RUN git clone https://github.com/rofl0r/microsocks.git /opt/microsocks \
    && cd /opt/microsocks \
    && make \
    && cp microsocks /usr/local/bin/microsocks \
    && rm -rf /opt/microsocks

# ---------- 目录 ----------
RUN mkdir -p /var/run/sshd /var/log/supervisor /srv/www /srv/data /srv/conf /scripts

# ---------- SSH 基础配置 ----------
RUN sed -ri 's/^#?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh

# ---------- Nginx + PHP-FPM 配置 ----------
COPY nginx/default.conf /etc/nginx/sites-available/default
COPY php/php.ini /etc/php/*/fpm/php.ini

# ---------- Supervisord 配置 ----------
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ---------- 假站页面 ----------
COPY www /srv/www

# ---------- 脚本 ----------
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

# ---------- tailscale & rclone 状态目录 ----------
RUN mkdir -p /var/lib/tailscale /root/.config/rclone

EXPOSE 7860
CMD ["/scripts/entrypoint.sh"]
