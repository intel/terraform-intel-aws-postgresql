# Example of how to pass variable for database password: 
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

variable "db_password" {
  description = "The admin password"
}

# Provision Intel Optimized AWS PostgreSQL server 
module "optimized-postgresql-server" {
  source      = "https://github.com/OTCShare2/terraform-intel-aws-postgresql"
  db_password = var.db_password

  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account 
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "vpc-XXX"
}