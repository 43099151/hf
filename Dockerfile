FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# 1) 系统包：同一层 update + install（更稳）[web:311]
# 2) PHP 用 php-fpm（默认版本），避免版本路径坑 [web:307]
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget vim git \
    supervisor nginx \
    php-fpm php-cli php-json php-curl php-mbstring php-xml php-zip \
    openssh-server rclone \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装 Tailscale（官方脚本方式）
RUN curl -fsSL https://tailscale.com/install.sh | sh

# 安装轻量 SOCKS5：microsocks
RUN git clone https://github.com/rofl0r/microsocks.git /opt/microsocks \
    && cd /opt/microsocks \
    && make \
    && cp microsocks /usr/local/bin/microsocks \
    && rm -rf /opt/microsocks

# 目录
RUN mkdir -p /var/run/sshd /var/log/supervisor /srv/www /srv/data /srv/conf /scripts \
    /var/lib/tailscale /root/.config/rclone \
    && mkdir -p /root/.ssh && chmod 700 /root/.ssh

# SSH 配置
RUN sed -ri 's/^#?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 配置文件
COPY nginx/default.conf /etc/nginx/sites-available/default
COPY php/php.ini /etc/php/*/fpm/php.ini
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 假站页面
COPY www /srv/www

# 脚本
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

EXPOSE 7860
CMD ["/scripts/entrypoint.sh"]
