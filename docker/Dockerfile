# syntax=docker/dockerfile:1

# Use the Python slim-buster Docker image as base.
# FROM python:slim-buster
FROM ubuntu:latest

# Set working directory.
WORKDIR /ansible

# Copy Ansible files to the container.
ADD ansible .

# Execute task.
CMD [ "bash", "/ansible/run.sh" ]
