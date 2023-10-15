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

################################################################################
# Security Groups
################################################################################

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.environment}-${var.id}-alb-sg"
  description = "Security group for the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = ["https-443-tcp", "http-80-tcp"]

}

module "asg_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.environment}-${var.id}-asg-sg"
  description = "Security group for the asg"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]
}   