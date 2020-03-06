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
  ssh-keygen -t rsa -b 4096 -C "$SSH_ROOT_KEY_NAME" -f /root/.ssh/id_rsa -q -P ""
  echo 'Built done. Below the public key to be added in your Git server:'
  cat /root/.ssh/id_rsa.pub
else
  echo 'The SSH key is already present so no need to build it'
fi
echo ''

echo 'Ensure permissions are good for the root SSH folder'
chmod 700 /root/.ssh
chmod 600 /root/.ssh/*.*
echo ''

#echo 'Recreate the Ansible configuration folder'
#rm -rf /etc/ansible
#mkdir /etc/ansible

echo 'Clone configuration files from the Git Repository'
git clone $ANSIBLE_CONFIG_GIT_URL /etc/ansible

echo 'infinite waiting so the container can be used at any time to launch Ansible operations'
while true; do sleep 10; done
