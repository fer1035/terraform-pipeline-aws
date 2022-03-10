#!/usr/bin/env bash

# Create credential values.
export PRIV="PRIVKEY"
export PUB="PUBKEY"

# Install SSH.
apt-get update
apt-get install openssh-client curl python3 -y

# Create credentials.
mkdir -p ~/.ssh
echo "$PRIV" > ~/.ssh/id_rsa
echo "$PUB" > ~/.ssh/id_rsa.pub
sed -i 's/\\n/\n/g' ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa*

# Install Ansible.
python3 -m pip install --upgrade pip
python3 -m pip install ansible

# Run Ansible and collect outputs.
cd /ansible
ansible-playbook playbook.yml -i inventory > log.txt

# Set output for Teams.
WEBHOOK="WEBHOOK_URL"
TITLE="Ansible Container Output"
MESSAGE=$(cat log.txt | sed 's/"/\"/g' | sed "s/'/\'/g")
JSON="{\"title\": \"${TITLE}\", \"text\": \"${MESSAGE}\"}"

# Send output to Teams.
curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
