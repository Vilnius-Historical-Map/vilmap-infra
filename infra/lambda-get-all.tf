module "lambda_get_all" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "lambda-get-all-events"

  runtime      = "python3.12"
  handler      = "index.handler"
  package_type = "Zip"

  s3_bucket = module.lambda_s3_bucket.s3_bucket_id
  s3_key    = "lambda-get-one/latest.zip"

  timeout        = 10
  vpc_subnet_ids = module.vpc.public_subnets
  vpc_security_group_ids = [module.lambda_sg.security_group_id]

  environment_variables = {
  }

  assume_role_policy_statements = {
    account_root = {
      effect = "Allow",
      actions = ["sts:AssumeRole"],
      principals = {
        service = {
          type = "Service"
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