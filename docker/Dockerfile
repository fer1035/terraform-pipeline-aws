# syntax=docker/dockerfile:1

# Use the Python slim-buster Docker image as base.
FROM python:slim-buster

# Set working directory.
WORKDIR /ansible

# # Install Python requirements.
# COPY requirements.txt requirements.txt
# RUN pip3 install -r requirements.txt

# Install Ansible and configure credential.
RUN pip3 install ansible && echo "PRIVKEY" >> /home/ignw/.ssl/id_rsa && echo "PUBKEY" >> /home/ignw/.ssl/id_rsa.pub && chmod 600 /home/ignw/.ssl/id_rsa*

# Copy Ansible files to the container.
COPY ../ansible .

# Execute Ansible playbook.
CMD [ "ansible-playbook", "-i" , "inventory" ]
