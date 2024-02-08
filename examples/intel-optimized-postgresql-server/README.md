<p align="center">
  <img src="https://github.com/intel/terraform-intel-aws-postgresql/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2024, Intel Corporation

## AWS RDS PostgreSQL module - Intel Optimized

This example creates an Intel optimized Amazon RDS PostgreSQL Server database instance. The instance is created on an Intel Icelake instance M6i.xlarge by default. The instance is pre-configured with parameters within the database parameter group that is optimized for Intel architecture. The goal of this module is to get you started with a database configured to run best on Intel architecture.

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements.

The PostgreSQL Optimizations were based off [Intel Xeon Tuning guides](<https://www.intel.com/content/www/us/en/developer/articles/guide/open-source-database-tuning-guide-on-xeon-systems.html>)

## Usage

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
module "optimized-postgres-server" {
  source         = ""intel/aws-postgresql/intel""
  rds_identifier = "postgres-dev"
  db_password    = var.db_password
  # Update the vpc_id below for the VPC that this module will use. Find the default vpc-id in your AWS account
  # from the AWS console or using CLI commands. In your AWS account, the vpc-id is represented as "vpc-",
  # followed by a set of alphanumeric characters. One sample representation of a vpc-id is vpc-0a6734z932p20c2m4
  vpc_id         = "<YOUR-VPC-ID-HERE>"
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

- Check in the variables.tf file for the region where this database instance will be created. It is defaulted to run in us-east-1 region within AWS. If you want to run it within any other region, make changes accordingly within the Terraform code

- Check the variables.tf file for incoming ports allowed to connect to the database instance. The variable name is ingress_cidr_blocks. Currently it is defaulted to be open to the world like 0.0.0.0/0. Before runing the code, configure it based on specific security policies and requirements within the environment it is being implemented

- Check if you getting errors while running this Terraform code due to AWS defined soft limits or hard limits within your AWS account. Please work with your AWS support team to resolve limit constraints


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.36.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_optimized-postgres-server"></a> [optimized-postgres-server](#module\_optimized-postgres-server) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Target AWS region to deploy workloads in. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_class"></a> [instance\_class](#output\_instance\_class) | Instance class in use for the database instance that was created. |
| <a name="output_postgres_address"></a> [postgres\_address](#output\_postgres\_address) | postgres instance hostname |
| <a name="output_postgres_allocated_storage"></a> [postgres\_allocated\_storage](#output\_postgres\_allocated\_storage) | Storage that was allocated to the instance when it configured. |
| <a name="output_postgres_arn"></a> [postgres\_arn](#output\_postgres\_arn) | ARN of the database instance. |
| <a name="output_postgres_backup_window"></a> [postgres\_backup\_window](#output\_postgres\_backup\_window) | Configured backup window for the database instance. |
| <a name="output_postgres_db_name"></a> [postgres\_db\_name](#output\_postgres\_db\_name) | Name of the database that was created (if specified) during instance creation. |
| <a name="output_postgres_endpoint"></a> [postgres\_endpoint](#output\_postgres\_endpoint) | Connection endpoint for the postgres instance that has been created |
| <a name="output_postgres_engine"></a> [postgres\_engine](#output\_postgres\_engine) | Database instance engine that was configured. |
| <a name="output_postgres_kms_key_id"></a> [postgres\_kms\_key\_id](#output\_postgres\_kms\_key\_id) | KMS key that is configured on the database instance if storage encryption is enabled. |
| <a name="output_postgres_maintenance_window"></a> [postgres\_maintenance\_window](#output\_postgres\_maintenance\_window) | Maintainence window for the database instance. |
| <a name="output_postgres_max_allocated_storage"></a> [postgres\_max\_allocated\_storage](#output\_postgres\_max\_allocated\_storage) | Maximum storage allocation that is configured on the database instance. |
| <a name="output_postgres_password"></a> [postgres\_password](#output\_postgres\_password) | postgres instance master password. |
| <a name="output_postgres_port"></a> [postgres\_port](#output\_postgres\_port) | postgres instance port |
| <a name="output_postgres_status"></a> [postgres\_status](#output\_postgres\_status) | Status of the database instance that was created. |
| <a name="output_postgres_username"></a> [postgres\_username](#output\_postgres\_username) | postgres instance root username |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
