# syntax=docker/dockerfile:1

# Use the Python slim-buster Docker image as base.
FROM python:slim-buster

# Set working directory.
WORKDIR /ansible

# # Install Python requirements.
# COPY requirements.txt requirements.txt
# RUN pip3 install -r requirements.txt

# Copy Ansible files to the container.
COPY ../ansible .

# Copy Ansible credentials.
COPY ../docker/id_rsa /home/ignw/.ssh/
COPY ../docker/id_rsa.pub /home/ignw/.ssh/

# Install SSH and Ansible, and configure credential.
RUN apt-get update && apt-get install openssh-server -y && systemctl start ssh && pip3 install ansible && chmod 600 /home/ignw/.ssh/id_rsa*

# Execute Ansible playbook.
CMD [ "ansible-playbook", "playbook.yml", "-i" , "inventory" ]
