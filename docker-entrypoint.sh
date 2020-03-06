#!/bin/sh
echo 'Container Ansible is starting'
echo 'List of information about main products used:'
ansible --version
ansible-playbook --version
git --version
ssh -V
cat /etc/os-release
uname -a
echo ''

if [ ! -f /root/.ssh/id_rsa ]; then
  echo 'Building the SSH key for the Git server'
  ssh-keygen -t rsa -b 4096 -C "$SSH_KEY_NAME" /root/.ssh/id_rsa -q -P ""
  echo 'Built done. Below the public key to be added in your Git server:'
  cat /root/.ssh/id_rsa.pub
else
  echo 'The SSH key is already present so no need to build it'
fi
echo ''
while true; do sleep 10; done
