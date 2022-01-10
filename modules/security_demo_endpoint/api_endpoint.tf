# Endpoint.

resource "aws_api_gateway_resource" "resource" {
  path_part   = "event"
  parent_id   = var.api_root_id
  rest_api_id = var.api_id
}

# Endpoint model.

resource "aws_api_gateway_model" "model" {
  rest_api_id  = var.api_id
  name         = "RequestModel"
  description  = "Request schema model."
  content_type = "application/json"
  schema       = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "UserModel",
  "type": "object",
  "required": ["myname"],
  "properties": {
    "myname": {
      "type": "string"
    }
  },
  "additionalProperties": false
}
EOF
}

# Endpoint method.

resource "aws_api_gateway_method" "method" {
  rest_api_id      = var.api_id
  resource_id      = aws_api_gateway_resource.resource.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true
  request_models = {
    "application/json" = aws_api_gateway_model.model.name
  }
  request_parameters = {
    "method.request.header.x-api-key"    = true
    "method.request.header.content-type" = true
    "method.request.querystring.code"    = true
  }
  request_validator_id = var.api_validator
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = var.api_id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.function.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "${var.api_execution_arn}/*/${aws_api_gateway_method.method.http_method}/${aws_api_gateway_resource.resource.path_part}"
}

# Endpoint CORS.

resource "aws_api_gateway_method" "options" {
  rest_api_id      = var.api_id
  resource_id      = aws_api_gateway_resource.resource.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
}
resource "aws_api_gateway_method_response" "options" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}
resource "aws_api_gateway_integration" "options" {
  rest_api_id          = var.api_id
  resource_id          = aws_api_gateway_resource.resource.id
  http_method          = "OPTIONS"
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
  #   # Transforms the incoming XML request to JSON
  #   request_templates = {
  #     "application/xml" = <<EOF
  # {
  #    "body" : $input.json('$')
  # }
  # EOF
  #   }
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
}
resource "aws_api_gateway_integration_response" "options" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_integration.options.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  #   # Transforms the backend JSON response to XML
  #   response_templates = {
  #     "application/xml" = <<EOF
  # #set($inputRoot = $input.path('$'))
  # <?xml version="1.0" encoding="UTF-8"?>
  # <message>
  #     $inputRoot.body
  # </message>
  # EOF
  #   }
}

# Outputs.

output "api_endpoint" {
  value     = "${var.api_url}/${aws_api_gateway_resource.resource.path_part}"
  sensitive = false
}
