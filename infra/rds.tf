module "rds" {
  source     = "terraform-aws-modules/rds/aws"
  identifier = var.rds_identifier

  major_engine_version                = var.rds_engine_version
  auto_minor_version_upgrade          = true
  engine                              = var.engine_name
  instance_class                      = var.rds_instance_class
  allocated_storage                   = var.rds_allocated_storage
  family                              = var.rds_family
  port                                = var.rds_port
  iam_database_authentication_enabled = false

  manage_master_user_password = false
  password                    = data.aws_ssm_parameter.db_password.value
  username                    = data.aws_ssm_parameter.db_username.value
  db_name                     = var.rds_db_name

  monitoring_role_name   = var.rds_monitoring_role_name
  create_monitoring_role = true

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  deletion_protection    = true

  vpc_security_group_ids = [module.rds_sg.security_group_id]
  tags = var.tags
}