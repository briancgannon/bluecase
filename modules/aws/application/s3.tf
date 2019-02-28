resource "aws_s3_bucket" "bluecase-terraform-state" {
   bucket_prefix = "bluecase-${var.env-name}-terraform-state"
   acl           = "private"
   
   versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "bluecase-terraform-state"
    }
}