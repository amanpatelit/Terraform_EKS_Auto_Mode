module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name          = "my-vpc"
  cidr          = var.cidr
  use_ipam_pool = false

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}