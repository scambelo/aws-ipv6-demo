terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.1"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      project    = "aws-ipv6-demo"
      managed-by = "terraform"
    }
  }
}