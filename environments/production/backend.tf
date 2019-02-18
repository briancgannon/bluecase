terraform {
  backend "s3" {
    bucket = "terraform-state-production-"
    key    = "production/terraform.tfstate"
    encrypt = true
    region  = "us-east-2"
    dynamodb_table = "terraform-state-production"
  }

  required_version = "=0.11.8"
}