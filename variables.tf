variable "aws_access_key" {
  description = "AWS access key"
  nullable    = false
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS access secret"
  nullable    = false
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
  nullable    = false
}

variable "availability_zone1" {
  description = "AWS region"
  default     = "us-east-1a"
  nullable    = false
}

variable "availability_zone2" {
  description = "AWS region"
  default     = "us-east-1b"
  nullable    = false
}

variable "project_name" {
  description = "Project name"
  default     = "revolent-tower"
  nullable    = false
}

variable "docker_image" {
  description = "Docker image name with tag"
  default     = "revolent/revolent-tower:v1"
  nullable    = false
}

variable "environment" {
  description = "Environment"
  default     = "dev"
  nullable    = false
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
  nullable    = false
}

variable "vpc_public_subnets" {
  description = "VPC CIDR for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  nullable    = false
}

variable "vpc_private_subnets" {
  description = "VPC CIDR for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  nullable    = false
}

variable "node_group_instance_types" {
  description = "A new node group instance will be created using one of these instance types."
  default     = ["t3.small"]
  nullable    = false
}

