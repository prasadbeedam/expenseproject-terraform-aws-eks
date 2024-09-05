terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {
    bucket = "prasad-remote-state"
    key    = "expense-dev-bastion"
    region = "us-east-1"
    dynamodb_table = "eks-infra-locking"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}