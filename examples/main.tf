# Example of how to pass variables for vpc-id and password: 
# terraform apply -var="db_password=..." -var="vpc_id=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

variable "vpc_id" {
  description = "id of the vpc"
  type        = string
}

variable "db_password" {
  description = "The admin password"
}

# Provision Intel Optimized AWS PostgreSQL server 
module "optimized-postgresql-server" {
  source      = "intel/terraform-intel-aws-postgresql"
  vpc_id      = var.vpc_id
  db_password = var.db_password
}