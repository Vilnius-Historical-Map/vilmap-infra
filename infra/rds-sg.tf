module "rds_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS database"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = var.rds_port
      to_port                  = var.rds_port
      protocol                 = "tcp"
      source_security_group_id = module.bastion_sg.security_group_id
    },
    {
      from_port                = var.rds_port
      to_port                  = var.rds_port
      protocol                 = "tcp"
      source_security_group_id = module.lambda_sg.security_group_id
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}