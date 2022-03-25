# Connect Terraform to AWS.
terraform {
  backend "remote" {
    organization = "fer1035"
    workspaces {
      name = "aws02"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.7.0"
    }
  }
  required_version = ">= 1.1.7"
}

/* # Call credentials from remote secrets.
variable "dev_access_key_id" {
  type      = string
  sensitive = true
}
variable "dev_secret_access_key" {
  type      = string
  sensitive = true
} */
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
