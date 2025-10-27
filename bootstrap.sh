#!/bin/bash

growpart /dev/nvme0n1 4
lvextend -L +5G /dev/RootVG/rootVol
lvextend -L +15G /dev/RootVG/homeVol

sudo xfs_growfs /
sudo xfs_growfs /home

# Docker Installation
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and Add permission to Docker
sudo systemctl start docker
sudo systemctl enable docker
# sudo systemctl status docker
sudo usermod -aG docker ec2-user

# eksctl Installation
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

#kubectl Installation
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

eksctl version
kubectl version

# kubens Installation
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Helm Installation
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# k9s Installation
sudo curl -sS https://webinstall.dev/k9s | bash