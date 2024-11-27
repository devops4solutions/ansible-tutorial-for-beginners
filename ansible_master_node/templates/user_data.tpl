#!/bin/bash
sudo adduser ansible
echo -e "${ansible_user_password}" | sudo chpasswd
echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers > /dev/null
sudo -su ansbile
mkdir -p /home/ansible/.ssh
ssh-keygen -t rsa -b 4096 -C "ansible" -f home/ansible/.ssh/id_rsa
sudo chown ansible:ansible /home/ansible/.ssh/id_rsa
sudo chown ansible:ansible /home/ansible/.ssh/id_rsa.pub
sudo yum install -y ansible

