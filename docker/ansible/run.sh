#!/usr/bin/env bash

# Create credential values.
export PRIV="PRIVKEY"
export PUB="PUBKEY"

# Install SSH.
apt-get update
apt-get install openssh -y 

# Create credentials.
mkdir -p ~/.ssh
echo "$PRIV" > ~/.ssh/id_rsa
echo "$PUB" > ~/.ssh/id_rsa.pub
sed -i 's/\\n/\n/g' ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa*

pip3 install ansible

cd /ansible
ansible-playbook playbook.yml -i inventory
