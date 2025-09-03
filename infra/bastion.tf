module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-bastion"

  instance_type = var.bastion_instance_type
  subnet_id     = module.vpc.public_subnets[0]

  create_iam_instance_profile = true

  iam_role_name = "${var.project_name}-bastion-role"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = var.tags
}