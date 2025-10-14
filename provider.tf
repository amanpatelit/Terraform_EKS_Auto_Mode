terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "letscodeanddeploy"
    key            = "eks-auto/terraform.tfstate"
    region         = "ap-south-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }
}

provider "aws" {
  region = var.region
}
