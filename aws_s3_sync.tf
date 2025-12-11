resource "null_resource" "sync_operational_data" {
  provisioner "local-exec" {
    command = <<EOT
      aws s3 sync ./data/customers s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers
      aws s3 sync ./data/addresses s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Addresses
      aws s3 sync ./data/orders s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Orders
      aws s3 sync ./data/memberships s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Memberships
      aws s3 sync ./data/customers_stream s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers_stream
      aws s3 sync ./data/customers_autoloader s3://${var.s3_bucket_name}/gizmobox/landing/operational-data/Customers_autoloader
      aws s3 sync ./data/circuitbox/addresses s3://${var.s3_bucket_name}/circuitbox/landing/operational-data/Addresses
      aws s3 sync ./data/circuitbox/customers s3://${var.s3_bucket_name}/circuitbox/landing/operational-data/Customers
      aws s3 sync ./data/circuitbox/orders s3://${var.s3_bucket_name}/circuitbox/landing/operational-data/Orders
      aws s3api put-object --bucket ${var.s3_bucket_name} --key circuitbox/lakehouse/
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
