#!/bin/bash -xe
# Faster than VirtualBox's DNS Server
sed -i 's/127.0.0.53/1.1.1.1/' /etc/resolv.conf

swapoff -a
sed -i '/swap/d' /etc/fstab

# 1.21 has a bug that effects certificate validation
snap install microk8s --classic --channel=1.20/stable

# Waits until K8s cluster is up
sleep 15

microk8s.enable dns
microk8s.enable metallb:192.168.50.100-192.168.50.200

mkdir -p /home/vagrant/.kube
microk8s config > /home/vagrant/.kube/config
usermod -a -G microk8s vagrant
chown -f -R vagrant /home/vagrant/.kube

curl https://get.docker.com | sh -
usermod -aG docker vagrant
