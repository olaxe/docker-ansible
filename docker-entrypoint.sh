#!/bin/sh
echo 'Container Ansible is starting'
ansible --version
ansible-playbook --version
while true; do sleep 10; done
