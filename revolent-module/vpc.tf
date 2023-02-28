module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs                = [var.availability_zone1, var.availability_zone2]
  public_subnets     = var.vpc_public_subnets
  private_subnets    = var.vpc_private_subnets
  enable_nat_gateway = true
  single_nat_gateway = true

  # Note: You can make this true if you need high availability (single_nat_gateway should be faslse)
  # This will create one nat gateway for each az you defined above (if true)
  one_nat_gateway_per_az = false

  tags = {
    Name        = "${var.project_name}-vpc-${var.environment}"
    Environment = var.environment
  }
}
