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
  default_tags {
    tags = {
      "DeployedBy" = "terraform"
      "DeploymentSource" = "spilliams/terraform-modules.git//terraform/examples/hugo/main.tf"
      "Domain" = "example.com"
      "Owner" = "@spilliams"
    }
  }
}

module "tld" {
  source = "../../modules/tld"
  
  domain_name = "example.com"
}

module "blog" {
  source = "../../modules/static-site"

  domain_name = "blog.example.com"
  acm_certificate_arn = module.tld.certificate_arn
}

resource "aws_route53_record" "blog" {
  zone_id = module.tld.hosted_zone_id
  name    = "blog"
  type    = "NS"
  ttl     = "30"
  records = module.blog.name_servers
}
