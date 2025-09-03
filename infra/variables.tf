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

# RDS
variable "rds_identifier" {
  type    = string
  default = "vilmapdb"
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
