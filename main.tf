terraform {
  cloud {
    organization = "ysugrad"
    workspaces {
        name = "vpc-workspace"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc_example_simple-vpc" {
  source  = "terraform-aws-modules/vpc/aws//examples/simple-vpc"
  version = "3.14.2"
}