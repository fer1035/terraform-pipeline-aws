#!/usr/bin/env bash

# Test command.
MESSAGE="$(date)"

# Set output for Teams.
TITLE="ANSIBLE_TITLE"
JSON="{\"title\": \"${TITLE}\", \"text\": \"${MESSAGE}\"}"

# Send output to Teams.
curl -H "Content-Type: application/json" -d "${JSON}" "ANSIBLE_WEBHOOK_URL"
