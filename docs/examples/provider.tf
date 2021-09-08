terraform {
  required_version = ">= 1.0.6"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.0"
      configuration_aliases = [aws.ue1]
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = local.profile
}

provider "aws" {
  alias   = "ue1"
  region  = "us-east-1"
  profile = local.profile
}
