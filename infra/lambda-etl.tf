module "lambda_etl" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = "${var.project_name}-lambda-etl"

  runtime      = var.lambda_runtime
  handler      = var.lambda_handler
  package_type = "Zip"

  create_package = false
  s3_existing_package = {
    bucket = module.lambda_s3_bucket.s3_bucket_id
    key    = var.lambda_etl_key
  }
  environment_variables = {
    DB_HOST = module.rds.db_instance_address
    DB_PORT = module.rds.db_instance_port
    DB_NAME = module.rds.db_instance_name
  }

  timeout        = var.lambda_timeout
  vpc_subnet_ids = module.vpc.intra_subnets
  vpc_security_group_ids = [module.lambda_sg.security_group_id]

  assume_role_policy_statements = {
    account_root = {
      effect = "Allow"
      actions = ["sts:AssumeRole"]
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
    s3_access = {
      effect = "Allow"
      actions = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      resources = [
        module.data_s3_bucket.s3_bucket_arn,
        "${module.data_s3_bucket.s3_bucket_arn}/*"
      ]
    }
    ssm_read = {
      effect = "Allow"
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ]
      resources = [
        "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/vilmap/prod/db-password",
        "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/vilmap/prod/db-user"
      ]
    }
  }

  tags = var.tags
}

data "aws_caller_identity" "current" {}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = module.vpc.intra_route_table_ids
      tags = { Name = "s3-vpc-endpoint" }
    }
  }
}
