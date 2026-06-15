#!/bin/bash

# Extend partition
sudo growpart /dev/nvme0n1 4

# Extend logical volume for /home
sudo lvextend -r -L +30G /dev/mapper/rootvg-homevol
xfs_growfs /home
echo "✅ /home disk extended successfully"

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform