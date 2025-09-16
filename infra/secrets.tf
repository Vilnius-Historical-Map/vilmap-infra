data "aws_ssm_parameter" "db_username" {
  name            = "/${var.project_name}/prod/db-user"
  with_decryption = true
}

data "aws_ssm_parameter" "db_password" {
  name            = "/${var.project_name}/prod/db-password"
  with_decryption = true
}