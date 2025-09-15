variable "project_name" {
  description = "Prefix for every service"
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "tags" {
  description = "Tags for every service instance"
  type = map(string)
}

# VPC
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "intra_subnets" {
  type = list(string)
  default = ["10.0.51.0/24", "10.0.52.0/24"]
}

# RDS
variable "rds_identifier" {
  type    = string
  default = "vilmapdb"
}

variable "engine_name" {
  type    = string
  default = "postgres"
}

variable "rds_engine_version" {
  type    = string
  default = "17"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type    = number
  default = 10
}

variable "rds_family" {
  type    = string
  default = "postgres17"
}

variable "rds_port" {
  type    = number
  default = 5432
}

variable "rds_db_name" {
  type    = string
  default = "vilmapDB"
}

variable "rds_monitoring_role_name" {
  type    = string
  default = "VilmapRDSMonitoringRole"
}

# Bastion
variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subdomain" {}

# Lambda
variable "lambda_runtime" {
  type    = string
  default = "python3.12"
}

variable "lambda_handler" {
  type    = string
  default = "index.handler"
}

variable "lambda_timeout" {
  type    = number
  default = 120
}

variable "lambda_get_one_key" {
  type        = string
  default     = "lambda-get-one/latest.zip"
  description = "S3 key for get-one Lambda zip"
}

variable "lambda_get_all_key" {
  type        = string
  default     = "lambda-get-all/latest.zip"
  description = "S3 key for get-all Lambda zip"
}

variable "lambda_etl_key" {
  type        = string
  default     = "lambda-etl/latest.zip"
  description = "S3 key for elt Lambda zip"
}
# API Gateway
variable "api_subdomain" {
  type    = string
  default = "api"
}

variable "domain" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "zone_id" {
  type = string
}