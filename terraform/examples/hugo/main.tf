terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket  = "spilliams-terraform-state"
    encrypt = true
    key     = "github.com-spilliams-terraform-modules/examples/hugo/terraform.tfstate"
    region  = "us-west-2"
    dynamodb_table = "spilliams-terraform-state"
  }
}

provider "aws" {
  region = "us-west-2"
}

module "site" {
  source = "../../modules/static-site"

  domain_name = "example.com"
}
