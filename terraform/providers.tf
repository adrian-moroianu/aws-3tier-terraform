### Providers requirements ###
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

### Configure the AWS Provider ###
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = "dev"
      Owner       = "DevOps"
      Project     = "AWS-3-tier"
    }
  }
}