data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

variable "family_name" {
    type    = string
    default = "api_test"
}

variable "image_name" {
    type    = string
    default = "531133914787.dkr.ecr.us-east-1.amazonaws.com/api-container:latest"
}

variable "instance_count" {
    type = number
    default = 1
}

variable "force_new" {
    type = bool
    default = false
}
