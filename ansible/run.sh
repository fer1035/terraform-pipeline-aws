#!/usr/bin/env bash

# Ansible command.
MESSAGE=$(ANSIBLE_CMD)

# Format output structure.
MESSAGETXT="$(echo $MESSAGE | sed 's/\*//g' | sed 's/\"//g')"
MESSAGETXT="${MESSAGETXT//$'\n'/<br>}"

# Send output to Teams.
curl -X POST -H "Content-Type: application/json" -d "{\"@context\": \"http://schema.org/extensions\",\"@type\": \"MessageCard\", \"title\":\"ANSIBLE_TITLE\", \"text\": \"${MESSAGETXT}\"}" "ANSIBLE_WEBHOOK_URL"
