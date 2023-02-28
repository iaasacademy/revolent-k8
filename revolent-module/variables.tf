variable "aws_region" {
  description = "AWS region"
  nullable    = false
}

variable "availability_zone1" {
  description = "AWS region"
  nullable    = false
}

variable "availability_zone2" {
  description = "AWS region"
  nullable    = false
}

variable "project_name" {
  description = "Project name"
  nullable    = false
}

variable "docker_image" {
  description = "Docker image name with tag"
  nullable    = false
}

variable "environment" {
  description = "Environment"
  nullable    = false
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  nullable    = false
}

variable "vpc_public_subnets" {
  description = "VPC CIDR for public subnets"
  nullable    = false
}

variable "vpc_private_subnets" {
  description = "VPC CIDR for private subnets"
  nullable    = false
}

variable "node_group_instance_types" {
  description = "A new node group instance will be created using one of these instance types."
  nullable    = false
}
