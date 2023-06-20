# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Optimized AWS PostgreSQL server in a new VPC

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.18.1"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Identifying subnets from the vpc created above. The subnets will be used to create the aws_db_subnet_group for the database resource
data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}

module "optimized-postgres-server" {
  source                = "intel/aws-postgresql/intel"
  rds_identifier        = "postgres-dev"
  db_password           = var.db_password
  create_security_group = true
  create_subnet_group   = true

  # The vpc-id for the database server will be referenced based on the new VPC being created from the prior module
  vpc_id = module.vpc.vpc_id
}