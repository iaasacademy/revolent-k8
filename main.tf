terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

module "revolent-tower" {
  source                    = "./revolent-module"
  aws_region                = var.aws_region
  availability_zone1        = var.availability_zone1
  availability_zone2        = var.availability_zone2
  project_name              = var.project_name
  docker_image              = var.docker_image
  vpc_cidr                  = var.vpc_cidr
  vpc_public_subnets        = var.vpc_public_subnets
  vpc_private_subnets       = var.vpc_private_subnets
  node_group_instance_types = var.node_group_instance_types
  environment               = var.environment
}

output "website_url" {
  value = module.revolent-tower.website_url
}
