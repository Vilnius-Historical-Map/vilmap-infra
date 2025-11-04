provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "vilmap-backend"
    use_lockfile = true
    key    = "infra/state"
    region = "eu-north-1"
  }
}