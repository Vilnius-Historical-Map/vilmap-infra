data "aws_ssm_parameter" "db_username" {
  name            = "vilmap/prod/db-username"
  with_decryption = true
}

data "aws_ssm_parameter" "db_password" {
  name            = "vilmap/prod/db-name"
  with_decryption = true
}