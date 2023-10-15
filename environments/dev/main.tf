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

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
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
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}

################################################################################
# Policy
################################################################################

module "iam-policy" {
  source      = "../../modules/policy"
  environment = var.environment
  id          = var.id
}

################################################################################
# Application Loadbalancer
################################################################################

module "alb" {
    source = "../../modules/alb"
    environment = var.environment
    id = var.id
    security_group_ids = toset([module.alb_sg.security_group_id])
    vpc_id = module.vpc.vpc_id
    alb_subnets = toset(module.vpc.public_subnets)
}

################################################################################
# Autoscaling group
################################################################################

module "asg" {
    source = "../../modules/asg"
    environment = var.environment
    id = var.id
    ami_id = var.ami_id
    key_name = var.key_name
    user_data = var.user_data
    security_group_ids = toset([module.asg_sg.security_group_id])
    iam_role = module.iam-policy.iam_role
    asg_subnets = toset(module.vpc.private_subnets)
    alb_target_group_arn = module.alb.alb_target_group_arn

}