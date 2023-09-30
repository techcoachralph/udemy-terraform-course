provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = var.AWS_REGION
}

variable "AWS_REGION" {
  type = string
}

variable "AMIS" {
  type=map(string)
  default = {
    us-east-1 = "ami-03a6eaae9938c858c"
  }
}

