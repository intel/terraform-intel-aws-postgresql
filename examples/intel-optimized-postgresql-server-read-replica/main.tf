# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS PostgreSQL server in an existing vpc and create a read replica in a different 
# availability zone than the primary database server

module "optimized-postgres-server" {
  source         = "../../"
  rds_identifier = "postgres-dev"
  db_password    = var.db_password

  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "<YOUR-VPC-ID-HERE>"
}

module "optimized-postgres-server-read-replica" {
  source         = "../../"
  rds_identifier = "postgres-dev-replica"
  db_password    = var.db_password

  # Update the vpc-id below. Use the same vpc-id as the one used in the prior module.
  vpc_id = "<YOUR-VPC-ID-HERE>"
  aws_database_instance_identifier = "postgresql-rr"
  db_engine_version = null
  db_replicate_source_db = module.optimized-postgres-server.db_instance_id
}