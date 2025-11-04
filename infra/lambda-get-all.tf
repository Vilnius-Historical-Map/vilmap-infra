module "lambda_get_all" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "${var.project_name}-lambda-get-all"

  runtime      = var.lambda_runtime
  handler      = var.lambda_handler
  package_type = "Zip"

  create_package = false
  s3_existing_package = {
    bucket = module.lambda_s3_bucket.s3_bucket_id
    key    = var.lambda_get_all_key
  }
  environment_variables = {
    DB_HOST     = module.rds.db_instance_address
    DB_PORT     = module.rds.db_instance_port
    DB_NAME     = module.rds.db_instance_name
    DB_PASSWORD = data.aws_ssm_parameter.db_password.value
    DB_USERNAME = data.aws_ssm_parameter.db_username.value
  }

  timeout                = var.lambda_timeout
  vpc_subnet_ids         = module.vpc.public_subnets
  vpc_security_group_ids = [module.lambda_sg.security_group_id]
  layers = [
    "arn:aws:lambda:eu-north-1:770693421928:layer:Klayers-p312-SQLAlchemy:6",
    "arn:aws:lambda:eu-north-1:770693421928:layer:Klayers-p312-psycopg2-binary:1",
  ]

  assume_role_policy_statements = {
    account_root = {
      effect  = "Allow"
      actions = ["sts:AssumeRole"]
      principals = {
        service = {
          type        = "Service"
          identifiers = ["lambda.amazonaws.com"]
        }
      }
    }
  }

  attach_policy_statements = true
  policy_statements = {
    vpc_access = {
      effect = "Allow"
      actions = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      resources = ["*"]
    }
  }

  tags = var.tags
}
