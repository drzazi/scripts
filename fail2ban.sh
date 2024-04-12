#!/bin/bash

if [ -f /etc/debian_version ]; then
    OS="Debian"
elif [ -f /etc/redhat-release ]; then
    OS="CentOS"
else
    exit 1
fi

# Debian
if [ "$OS" = "Debian" ]; then
    apt-get install -y fail2ban
    systemctl start fail2ban
    systemctl enable fail2ban
    sudo cp /etc/fail2ban/jail.{conf,local}
    sudo bash -c 'echo "[DEFAULT]
ignoreip = 127.0.0.1/8

[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
bantime  = 1d
findtime  = 5m
maxretry = 3" > /etc/fail2ban/jail.local'
    systemctl restart fail2ban
    systemctl status fail2ban

# CentOS
elif [ "$OS" = "CentOS" ]; then
    yum install fail2ban -y
    systemctl start fail2ban
    systemctl enable fail2ban
    sudo cp /etc/fail2ban/jail.{conf,local}
    sudo bash -c 'echo "[DEFAULT]
ignoreip = 127.0.0.1/8

[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/secure
bantime  = 1d
findtime  = 5m
maxretry = 3" > /etc/fail2ban/jail.local'
    systemctl restart fail2ban
    systemctl status fail2ban
fi
