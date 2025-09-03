module "frontend_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.project_name}-frontend"

  website = {
    index_document = "index.html"
    #     error_document = "error.html"
  }

  versioning = {
    enabled = true
  }

  acl           = "private"
  force_destroy = true
  tags          = var.tags
}