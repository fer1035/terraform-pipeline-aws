variable "lambda_name" {
  type        = string
  description = "The name of the Lambda function."
  default     = "tf_lambda"
}

variable "lambda_description" {
  type        = string
  description = "The description of the Lambda function."
  default     = "Application security demo, deployed by Terraform."
}

variable "api_root_id" {
  type        = string
  description = "The root resource ID of the REST API in API Gateway."
}

variable "api_id" {
  type        = string
  description = "The ID of the REST API in API Gateway."
}

variable "api_validator" {
  type        = string
  description = "The validator ID for the REST API in API Gateway."
}

variable "api_execution_arn" {
  type        = string
  description = "The execution ARN of the REST API in API Gateway."
}
