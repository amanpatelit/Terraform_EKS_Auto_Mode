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


# Backend Configuration
terraform {
backend "s3" {
 bucket         = "letscodeanddeploy"
 key            = "aws/terraform/terraform.tfstate"
 region         = "ap-south-1"
 dynamodb_table = "devterraform"
 encrypt        = true
 }
}
