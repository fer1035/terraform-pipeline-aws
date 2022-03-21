#!/usr/bin/env bash

# Ansible command.
ANSIBLE_CMD > log.txt

# Format output structure.
MESSAGE="$(cat log.txt)"
MESSAGE="${MESSAGE//$'\n'/<br>}"

# Send output to Teams.
curl -H "Content-Type: application/json" -d "{\"@context\": \"http://schema.org/extensions\",\"@type\": \"MessageCard\", \"title\":\"ANSIBLE_TITLE\", \"text\": \"${MESSAGE}\"}" "ANSIBLE_WEBHOOK_URL"
