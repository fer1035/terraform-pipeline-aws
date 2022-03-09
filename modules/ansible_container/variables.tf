data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

variable "family_name" {
    type    = string
    default = "ansible"
}

variable "image_name" {
    type    = string
    default = "python:slim-buster"
}

variable "instance_count" {
    type    = number
    default = 1
}

variable "force_new" {
    type    = bool
    default = false
}

variable "subnet_1" {
    type    = string
    default = "subnet-072107252df3c7e87"
}

variable "subnet_2" {
    type    = string
    default = "subnet-03b71dab2f9a1bb6f"
}

variable "security_group" {
    type    = string
    default = "sg-05bd0031419bb91c5"
}

variable "public_ip" {
    type    = bool
    default = true
}
