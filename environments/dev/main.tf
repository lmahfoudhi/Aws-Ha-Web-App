################################################################################
# VPC
################################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment}-${var.id}-vpc"
  cidr = var.cidr

  azs             = var.az
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true

  tags = {
    Environment = var.environment
  }
}