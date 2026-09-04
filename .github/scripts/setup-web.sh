#!/bin/bash
set -e

echo "[*] Configuring Httpserver..."
dnf install -y httpd nfs-utils

# Mount NFS share directly to document root
mkdir -p /var/www/html
mount -t nfs 172.20.0.30:/mnt/nfs_share /var/www/html

# Start and enable Apache
systemctl enable --now httpd
