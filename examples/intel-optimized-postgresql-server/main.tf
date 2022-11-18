# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS PostgreSQL server
module "optimized-postgres-server" {
  source         = "../../"
  rds_identifier = "postgres-dev"
  db_password    = var.db_password
  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "<YOUR-VPC-ID-HERE>"
}