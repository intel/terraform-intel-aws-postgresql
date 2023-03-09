# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS PostgreSQL server in default vpc of the selected AWS region and create a read replica in a different 
# availability zone than the primary database server

module "optimized-postgres-server" {
#  source         = "intel/aws-postgresql/intel"
  source = "../../"
  rds_identifier = "postgres-dev"
  db_password    = var.db_password
  instance_class = "db.m6i.large"
  # Update the vpc_id below for the VPC that this module will use. Find the default vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "vpc-0abf36f0171c55ae1"
}

module "optimized-postgres-server-read-replica" {
#  source         = "intel/aws-postgresql/intel"
  source = "../../"
  rds_identifier = "postgres-dev-replica"
  db_password    = var.db_password
  instance_class = "db.m6i.large"
  # Update the vpc-id below. Use the same vpc-id as the one used in the prior module.
  vpc_id                           = "vpc-0abf36f0171c55ae1"
  db_replicate_source_db           = module.optimized-postgres-server.db_instance_id
  kms_key_id                       = module.optimized-postgres-server.db_kms_key_id
  skip_final_snapshot              = true
}