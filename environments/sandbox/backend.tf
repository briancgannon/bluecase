terraform {
  backend "s3" {
    bucket = "terraform-state-sandbox-"
    key    = "sandbox/terraform.tfstate"
    encrypt = true
    region  = "us-east-2"
    dynamodb_table = "terraform-state-sandbox"
  }

  required_version = "=0.11.8"
}