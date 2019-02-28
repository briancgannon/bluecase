terraform {
  backend "s3" {
    bucket = "terraform-state-sandbox-20190228142955887100000001"
    key    = "sandbox/terraform.tfstate"
    encrypt = true
    region  = "us-east-2"
    dynamodb_table = "terraform-state-sandbox"
  }

  required_version = "=0.11.8"
}
