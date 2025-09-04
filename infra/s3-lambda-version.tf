module "lambda_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${var.project_name}-lambda-version"

  versioning = {
    enabled = false
  }
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  force_destroy = true
  tags          = var.tags
}