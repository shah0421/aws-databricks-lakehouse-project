resource "aws_s3_bucket" "project_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "GizmoBox Project Bucket"
    Environment = "Dev"
  }
}
