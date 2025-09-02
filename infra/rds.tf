module "rds" {
  source = "terraform-aws-modules/rds/aws"
  identifier = "vilmapdb"

  major_engine_version                = "17"
  auto_minor_version_upgrade          = true
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 10
  family                              = "postgres17"
  port                                = "5432"
  iam_database_authentication_enabled = false

  manage_master_user_password = false
  password                    = data.aws_ssm_parameter.db_password
  username                    = data.aws_ssm_parameter.db_username
  db_name                     = "vilmapDB"

  monitoring_role_name   = "VilmapRDSMonitoringRole"
  create_monitoring_role = true

  create_db_subnet_group = true
  subnet_ids = [module.vpc.private_subnets]
  deletion_protection    = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}