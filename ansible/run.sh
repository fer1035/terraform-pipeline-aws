#!/usr/bin/env bash

# Ansible command.
MESSAGE=$(ANSIBLE_CMD)

# Format output structure.
MESSAGE="${MESSAGE//$*/}"
MESSAGE="${MESSAGE//$\"/}"
MESSAGE="${MESSAGE//$\'/}"
MESSAGE="${MESSAGE//$\n/<br>}"

# Send output to Teams.
curl -X POST -H "Content-Type: application/json" -d "{\"@context\": \"http://schema.org/extensions\",\"@type\": \"MessageCard\", \"title\":\"ANSIBLE_TITLE\", \"text\": \"${MESSAGE}\"}" "ANSIBLE_WEBHOOK_URL"
