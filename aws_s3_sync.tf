resource "null_resource" "sync_operational_data" {
  provisioner "local-exec" {
    command = <<EOT
      aws s3 sync ./data/Customers s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers
      aws s3 sync ./data/Addresses s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Addresses
      aws s3 sync ./data/Orders s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Orders
      aws s3 sync ./data/Memberships s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Memberships
    EOT

    environment = {
      AWS_REGION = var.aws_region
    }
  }

  triggers = {
    always_run = timestamp() # ensures provisioner runs every apply
  }

  depends_on = [aws_s3_bucket.project_bucket]
}

resource "null_resource" "sync_external_data" {
  provisioner "local-exec" {
    command = <<EOT
      aws s3 sync ./data/Payments s3://${var.s3_bucket_name}/gizmobox/landing/external-data/Payments
    EOT

    environment = {
      AWS_REGION = var.aws_region
    }
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [aws_s3_bucket.project_bucket]
}
