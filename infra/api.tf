module "http_api" {
  source        = "terraform-aws-modules/apigateway-v2/aws"
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["*"]
    allow_methods = ["GET"]
    allow_origins = ["https://${var.subdomain}${var.domain}"]
  }

  create_domain_name    = false
  create_domain_records = false

  stage_access_log_settings = {
    create_log_group            = true
    log_group_retention_in_days = 7
    format = jsonencode({
      requestId   = "$context.requestId"
      requestTime = "$context.requestTime"
      routeKey    = "$context.routeKey"
      status      = "$context.status"
      protocol    = "$context.protocol"
    })
  }

  routes = {
    "GET /event/{id}" = {
      integration = {
        uri                    = module.lambda_get_one.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 30000
      }
    }

    "GET /events" = {
      integration = {
        uri                    = module.lambda_get_all.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 30000
      }
    }
  }

  tags = var.tags
}

resource "aws_lambda_permission" "allow_invoke_get_one" {
  statement_id  = "AllowExecutionFromAPIGatewayGetOne"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_get_one.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.http_api.api_execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_invoke_get_all" {
  statement_id  = "AllowExecutionFromAPIGatewayGetAll"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_get_all.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.http_api.api_execution_arn}/*/*"
}
