resource "aws_s3_bucket" "bluecase-bucket" {
   bucket_prefix = "bluecase-${var.env_name}-"
   acl           = "private"
   
   versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "bluecase-${var.env_name}"
    }
}