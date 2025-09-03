module "bastion-sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${var.project_name}-bastion-sg"
  description = "Security group for bastion"
  vpc_id      = module.vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}