# Configs for resources used for Terraform state management.

provider "aws" {
  region = "us-east-1"
}

variable "environments" {
  default = [
    "production",
    "sandbox",
  ]
}

# Environment names must be 20 chars or less due to S3 naming limits. 
# Only append additional envs to the end of this list.  Do not attempt
# to re-order by name or else Terraform will not be happy.

# S3 state bucket
resource "aws_s3_bucket" "state_bucket" {
  count         = "${length(var.environments)}"
  bucket_prefix = "terraform-state-${element(var.environments, count.index)}-"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "state_table" {
  count          = "${length(var.environments)}"
  name           = "terraform-state-${element(var.environments, count.index)}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


