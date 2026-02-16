terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Backend config passed via -backend-config in CI (bucket, key, region)
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  environment        = var.environment
  project            = var.project
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  environment        = var.environment
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.public_subnet_ids[0]
  ami_name           = var.ec2_ami_name
  instance_type      = var.ec2_instance_type
  key_name           = var.ec2_key_name
  ssh_allowed_cidrs  = var.ec2_ssh_allowed_cidrs
}

module "cloudfront" {
  source = "./modules/cloudfront"

  environment    = var.environment
  project        = var.project
  origin_domain  = module.ec2.public_dns
  price_class    = var.cloudfront_price_class
}
