
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