module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${project-name}-bastion"

  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]

#   create_iam_instance_profile = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}