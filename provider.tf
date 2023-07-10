provider "aws" {

  region  = module.ENV.region
  default_tags {
    tags = {
      application-name = "neo-terraform-ecs"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  #backend "s3" {
  #  #bucket = "nride-terraform-staging"
  #  key    = "nride-terraform-ecs.tfstate"
  #  #region = "us-east-1"
  #}

}