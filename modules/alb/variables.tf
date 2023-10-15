variable "environment" {
  type        = string
  description = "The environment name for the resources."
}


variable "id" {
  type        = string
  description = "ID associated to the project"
}
variable "vpc_id" {
  type = string
  description = "the vpc where the loadbalancer will be deployed"
}
variable "alb_subnets" {
    type = set(string)
    description = "public subnets where the loadbalancer will be set"
}

variable "security_group_ids" {
  type = set(string)
  description = "Security groups associated to the loadbalancer"
}