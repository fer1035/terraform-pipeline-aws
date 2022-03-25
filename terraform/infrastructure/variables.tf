# Declare intrinsic variables.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

variable "aws_access_key_id" {
    type      = string
    default   = AWS_ACCESS_KEY_ID
}

variable "aws_secret_access_key" {
    type      = string
    default   = AWS_SECRET_ACCESS_KEY
}
