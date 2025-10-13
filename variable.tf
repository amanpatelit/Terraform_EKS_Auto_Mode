variable "eks" {
  type        = string
  description = "stage"
}

variable "cidr" {
  type        = string
  description = "stage"
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "private_subnets" {
  type        = list(string)
  description = "private_subnet"
}

variable "public_subnets" {
  type = list(string)
}