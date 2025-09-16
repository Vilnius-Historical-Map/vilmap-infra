module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-bastion"

  instance_type               = var.bastion_instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  create_security_group       = false

  create_iam_instance_profile = true
  iam_role_name               = "${var.project_name}-bastion-role"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  tags = var.tags
}