module "data_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${var.project_name}-data"

  versioning = {
    enabled = true
  }
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  force_destroy = true
  tags          = var.tags
}


module "data_s3_notifications" {
  source = "terraform-aws-modules/s3-bucket/aws//modules/notification"

  bucket = module.data_s3_bucket.s3_bucket_id

  lambda_notifications = {
    etl = {
      function_arn  = module.lambda_etl.lambda_function_arn
      function_name = module.lambda_etl.lambda_function_name
      events        = ["s3:ObjectCreated:*"]
      filter_suffix = ".csv"
    }
  }
}