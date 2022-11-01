# Amazon RDS PostgreSQL (PaaS) - Intel Cloud Optimized Recipe

Configuration in this directory creates an Amazon RDS instance for PostgreSQL. The instance is created on an Intel Icelake instance M6i.large by default. The instance is pre-configured with parameters within the database parameter group that is optimized for Intel architecture. The goal of this recipe is to get you started with a database configured to run best on Intel architecture.

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements.

## Usage

See examples folder for code ./examples/main.tf

By default, you will only have to pass one variable

```bash
db_password
```

Example of main.tf

```bash
variable "db_password" {
  description = "The admin password"
}

# Provision Intel Optimized AWS PostgreSQL server 
module "optimized-postgresql-server" {
  source      = "github.com/OTCShare2/terraform-intel-aws-postgresql"
  db_password = var.db_password

  # Update the vpc_id below for the VPC that this module will use. Find the vpc-id in your AWS account 
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id = "vpc-XXX"
}
```

Run Terraform

```bash
terraform init  
terraform plan -var="db_password=..." #Enter a complex password
terraform apply -var="db_password=..." #Enter a complex password
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Considerations
- Check in the variables.tf file for the region where this database instance will be created. For using any other AWS region, make changes accordingly within the Terraform code

- Check the variables.tf file for incoming ports allowed to connect to the database instance. The variable name is ingress_cidr_blocks. Currently it is defaulted to be open to the
world like 0.0.0.0/0. Before runing the code, configure it based on specific security policies and requirements within the environment it is being implemented

- Check if you getting errors while running this Terraform code due to AWS defined soft limits or hard limits within your AWS account. Please work with your AWS support team to resolve limit constraints