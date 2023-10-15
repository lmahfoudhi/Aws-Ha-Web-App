terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    version = "~> 5.0" }
  }
  backend "s3" {
    bucket         = "dev-pp-01-s3-bucket"
    key            = "state/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "dev-pp-01-dynamodb-table"
  }

}

provider "aws" {
  region = "us-west-2"
}
