resource "aws_kms_key" "bluecase-s3-kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "bluecase-terraform-state" {
   bucket_prefix = ""
   
   versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags {
      Name = "bluecase-terraform-state"
    }

    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = "${aws_kms_key.bluecase-s3-kms-key.arn}"
          sse_algorithm     = "aws:kms"
        }
      }
    }

}