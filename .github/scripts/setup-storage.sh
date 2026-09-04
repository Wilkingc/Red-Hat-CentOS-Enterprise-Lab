#!/bin/bash
set -e

echo "[*] Configuring nfsserver..."
dnf install -y nfs-utils

# Prepare export directory
mkdir -p /mnt/nfs_share
chmod 777 /mnt/nfs_share
echo "Shared NFS Asset verified at $(date)" > /mnt/nfs_share/index.html

# Configure exports for the lab subnet
echo "/mnt/nfs_share 172.20.0.0/24(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports

# Enable RPC and NFS services
systemctl enable --now rpcbind
systemctl enable --now nfs-server
for i in rpc-bind mountd nfs; do firewall-cmd --add-service $i --permanent; done
for i in rpc-bind mountd nfs; do firewall-cmd --add-service $i; done
exportfs -rav
