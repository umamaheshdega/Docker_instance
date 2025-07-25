#!/bin/bash
set -xe
DISK="/dev/xvda"
PART=4
VG_NAME="RootVG"
ROOT_LV="rootVol"
VAR_LV="varVol"
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

echo "🔧 Growing partition..."
growpart "$DISK" "$PART"

echo "🔄 Resizing physical volume..."
pvresize "${DISK}${PART}"

echo "➕ Extending root LV by 50% of FREE space..."
lvextend -l +50%FREE /dev/${VG_NAME}/${ROOT_LV}

echo "➕ Extending var LV with remaining FREE space..."
lvextend -l +100%FREE /dev/${VG_NAME}/${VAR_LV}

echo "📈 Growing XFS filesystem on / ..."
xfs_growfs /

echo "📈 Growing XFS filesystem on /var ..."
xfs_growfs /var

echo "✅ LVM resize complete."


dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

#kubectl installation
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

#eks installation
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

# Extract eksctl archive to /tmp, overwrite if needed
tar --overwrite -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm -f eksctl_$PLATFORM.tar.gz

# Install binary to /usr/local/bin, overwrite if already exists
sudo install -o root -g root -m 0755 /tmp/eksctl /usr/local/bin/eksctl && rm -f /tmp/eksctl

# Optional: Verify installation
eksctl version



