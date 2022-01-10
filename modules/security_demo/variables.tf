variable "api_name" {
  type        = string
  description = "The name of the REST API in API Gateway."
  default     = "tf_api"
  #  sensitive   = true
  #  validation {
  #    condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
  #    error_message = "Please provide a valid value for variable AMI."
  #  }
}

variable "api_description" {
  type        = string
  description = "The description of the REST API in API Gateway."
  default     = "Application security demo, deployed by Terraform."
}

variable "waf_name" {
  type        = string
  description = "The name of the Lambda function."
  default     = "StandardACL_Regional"
}
