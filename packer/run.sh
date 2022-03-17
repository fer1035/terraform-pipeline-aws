#!/usr/bin/env bash

# Test command.
MESSAGE="Python version: $(python3 --version) on $(date)"

# Set output for Teams.
TITLE="Container Output"
JSON="{\"title\": \"${TITLE}\", \"text\": \"${MESSAGE}\"}"

# Send output to Teams.
curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK}"
