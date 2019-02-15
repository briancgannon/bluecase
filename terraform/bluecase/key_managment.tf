resource "aws_kms_key" "bluecase-s3-kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}