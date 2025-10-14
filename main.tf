
# Create VPC using official AWS module


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.availability_zones

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Environment = "stage"
    Terraform   = "true"
  }
}


# Create EKS Auto Mode cluster using AWS module


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.30"
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  enable_cluster_creator_admin_permissions = true

  # Enable Auto Mode features
  enable_eks_auto_mode = true

  # Optional managed node group
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      capacity_type  = "SPOT"
    }
  }

  cluster_addons = {
    vpc-cni    = { most_recent = true }
    kube-proxy = { most_recent = true }
    coredns    = { most_recent = true }
  }

  tags = {
    Environment = "stage"
    Terraform   = "true"
  }
}
