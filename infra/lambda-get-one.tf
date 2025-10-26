module "lambda_get_one" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "${var.project_name}-lambda-get-one"

  runtime      = var.lambda_runtime
  handler      = var.lambda_handler
  package_type = "Zip"

  create_package = false
  s3_existing_package = {
    bucket = module.lambda_s3_bucket.s3_bucket_id
    key    = var.lambda_get_one_key
  }

  timeout                = var.lambda_timeout
  vpc_subnet_ids         = module.vpc.public_subnets
  vpc_security_group_ids = [module.lambda_sg.security_group_id]

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
