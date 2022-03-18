#!/usr/bin/env bash

# Ansible command.
ANSIBLE_CMD > log.txt
MESSAGE="$(cat log.txt)"

# Set output for Teams.
TITLE="ANSIBLE_TITLE"
JSON="{\"title\": \"${TITLE}\", \"text\": \"${MESSAGE}\"}"

# Send output to Teams.
curl -H "Content-Type: application/json" -d "${JSON}" "ANSIBLE_WEBHOOK_URL"
