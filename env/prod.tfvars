project_name = "vilmap"

tags = {
  Terraform   = "true"
  Environment = "prod"
  ProjectName = "Vilmap"
}

region = "eu-north-1"

domain    = "vilmap.click"
subdomain = ""
zone_id   = "Z07484993CJEBX0BD8VOJ"
zone_name = "vilmap.click"

# VPC
vpc_cidr = "10.0.0.0/16"
azs = ["eu-north-1a", "eu-north-1b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

# RDS
rds_identifier        = "vilmapdb"
rds_engine_version    = "17"
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = 10
engine_name           = "postgres"
rds_family            = "postgres17"
rds_port              = 5432
rds_db_name           = "vilmapDB"
rds_monitoring_role_name = "VilmapRDSMonitoringRole"

# Bastion
bastion_instance_type = "t3.micro"

# Lambda
lambda_get_one_key = "lambda-get-one/latest.zip"
lambda_get_all_key = "lambda-get-all/latest.zip"
lambda_etl_key     = "lambda-etl/latest.zip"
