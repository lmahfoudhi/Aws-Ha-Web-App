
variable "region" {
  type        = string
  description = "Region of the alb-asg"
}

variable "billing_mode" {
  type        = string
  description = "Billing mode for dynamodb"
}

variable "hash_key" {
  type        = string
  description = "Hash key name of dynamodb"
}

variable "attribute_name" {
  type        = string
  description = "Attribute name of dynamodb"
}

variable "attribute_type" {
  type        = string
  description = "Attribute type of dynamodb"
}


variable "environment" {
  type        = string
  description = "The environment name for the resources."
}


variable "id" {
  type        = string
  description = "ID associated to the project"
}

variable "cidr" {
  type        = string
  description = "vpc ip range"
  default     = "10.0.0.0/16"
}

variable "az" {
  type        = set(string)
  description = "Availability zones for the vpc"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "private_subnets" {
  type        = list(string)
  description = "ip range for the private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "ip range for the public subnets"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}