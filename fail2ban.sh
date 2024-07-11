#!/bin/bash

if [ -f /etc/debian_version ]; then
    OS="Debian"
    LOG_PATH="/var/log/auth.log"
elif [ -f /etc/redhat-release ]; then
    OS="CentOS"
    LOG_PATH="/var/log/secure"
else
    echo "Unsupported OS."
    exit 1
fi

# Get SSH port dynamically
SSHD_PORT=$(sshd -T | grep "^port " | awk '{print $2}')

# Install fail2ban
if [ "$OS" = "Debian" ]; then
    apt-get install -y fail2ban
elif [ "$OS" = "CentOS" ]; then
    yum install fail2ban -y
fi

# Configure fail2ban
cat << EOF > /etc/fail2ban/jail.local
[DEFAULT]
ignoreip = 127.0.0.1/8

[sshd]
enabled = true
backend = systemd
port = $SSHD_PORT
filter = sshd
logpath = $LOG_PATH
bantime = 1d
findtime = 5m
maxretry = 3
EOF

# Start and enable fail2ban
systemctl start fail2ban
systemctl enable fail2ban
systemctl restart fail2ban
systemctl status fail2ban
