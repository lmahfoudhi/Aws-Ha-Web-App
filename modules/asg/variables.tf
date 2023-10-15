variable "environment" {
  type        = string
  description = "The environment name for the resources."
}

variable "id" {
  type        = string
  description = "ID associated to the project"
}

variable "iam_role" {
  type        = string
  description = "instance profile role"
}

variable "ami_id" {
  type        = string
  description = "ami of the application"
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type"
}

variable "key_name" {
  type        = string
  description = "key to ssh to ec2 instance"
}

variable "security_group_ids" {
  type        = set(string)
  description = "security group attached to asg ec2 instances"
}

variable "user_data" {
  type        = string
  description = "command to initialize the asg ec2 instances"
}

variable "asg_subnets" {
  type        = set(string)
  description = "private subnets where the ec2 instances are deployed"
}

variable "alb_target_group_arn" {
  type        = string
  description = "alb that will load the balance to the asg instances"
}







