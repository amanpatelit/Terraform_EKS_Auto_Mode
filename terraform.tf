###############################################
# Create S3 Bucket for Terraform State Storage
###############################################

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "devterraforms3"
  force_destroy = true

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "dev"
  }
}

###############################################
# Enable Versioning on S3 Bucket
###############################################

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

###############################################
# Create DynamoDB Table for Terraform State Locking
###############################################

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "devterraform"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLockTable"
    Environment = "dev"
  }
}

###############################################
# Backend Configuration
###############################################
#terraform {
#backend "s3" {
# bucket         = "devterraforms3"
# key            = "aws/terraform/terraform.tfstate"
# region         = "ap-south-1"
# dynamodb_table = "devterraform"
# encrypt        = true
# }
#}
