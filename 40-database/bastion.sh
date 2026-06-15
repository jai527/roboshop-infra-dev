#!/bin/bash

set -e   # stop if any error

echo "Extending /home disk..."

# Extend partition
sudo growpart /dev/nvme0n1 4

# Extend logical volume for /home
sudo lvextend -r -L +30G /dev/mapper/rootvg-homevol
xfs_growfs /home
echo "✅ /home disk extended successfully"

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform