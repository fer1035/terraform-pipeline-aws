variable "subnet" {
    type        = string
    description = "The Subnet ID in which to launch the instance."
    default     = "SUBNET"
}

variable "instance_ip" {
    type        = string
    description = "The private IP to attach to the instance."
    default     = "INSTANCE_IP"
}

variable "security_group" {
    type        = string
    description = "The Security Group to attach to the instance."
    default     = "SEC_GRP"
}

variable "ami" {
    type        = string
    description = "The AMI to attach to the instance."
    default     = "AMI"
}

variable "public_key" {
    type        = string
    sensitive   = true
    default     = "PUBLIC_KEY"
}

variable "remote_user" {
    type        = string
    description = "The user in the target instance for Ansible execution."
    default     = "REMOTE_USER"
}
