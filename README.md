<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## AWS RDS PostgreSQL module

This module can be used to deploy an Intel optimized Amazon RDS PostgreSQL Server database instance.
Instance selection and PostgreSQL optimization are included by default in the code.

The PostgreSQL Optimizations were based off [Intel Xeon Tunning guides](<https://www.intel.com/content/www/us/en/developer/articles/guide/open-source-database-tuning-guide-on-xeon-systems.html>)

## Usage

**See examples folder for complete examples.**

By default, you will only have to pass three variables

```hcl
db_password
rds_identifier
vpc_id
```

variables.tf

```hcl
variable "db_password" {
  description = "Password for the master database user."
  type        = string
  sensitive   = true
}
```

main.tf

```hcl
module "optimized-postgresql-server" {
  source         = "github.com/intel/terraform-intel-aws-postgresql"
  db_password    = var.db_password
  rds_identifier = "<NAME-FOR-RDS-INSTANCE>"
  vpc_id         = "<YOUR-VPC-ID>"
}
```

Run Terraform

```hcl
export TF_VAR_db_password ='<USE_A_STRONG_PASSWORD>'

terraform init  
terraform plan
terraform apply 
```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources.

## Considerations

- Check in the variables.tf file for the region where this database instance will be created. For using any other AWS region, make changes accordingly within the Terraform code

- Check if you getting errors while running this Terraform code due to AWS defined soft limits or hard limits within your AWS account. Please work with your AWS support team to resolve limit constraints

<!-- BEGIN_TF_DOCS -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
