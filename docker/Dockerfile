# syntax=docker/dockerfile:1

# Use the Python slim-buster Docker image as base.
FROM python:slim-buster

# Set working directory.
WORKDIR /ansible

# # Install Python requirements.
# COPY requirements.txt requirements.txt
# RUN pip3 install -r requirements.txt

# Install Ansible and configure credential.
RUN pip3 install ansible && echo "PUBKEY" >> /home/ignw/.ssl/authorized_keys

# Copy Ansible files to the container.
COPY ../ansible .

# Execute Ansible playbook.
CMD [ "ansible-playbppk", "-i" , "inventory" ]
