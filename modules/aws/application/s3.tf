resource "aws_s3_bucket" "bluecase-bucket" {
   bucket_prefix = "bluecase-${var.env_name}-"
   acl           = "private"

    tags {
      Name = "bluecase-${var.env_name}"
    }
}