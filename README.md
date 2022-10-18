# Amazon RDS PostgreSQL (PaaS) - Intel Cloud Optimized Recipe

Configuration in this directory creates an Amazon RDS instance for PostgreSQL. The instance is created on an Intel Icelake instance M6i.large. The instance is pre-configured with parameters within the database parameter group that is optimized for Intel architecture. The goal of this recipe is to get you started with a database configured to run best on Intel architecture.

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Considerations
- Check in the variables.tf file for the region where this database instance will be created. It is defaulted to run in ap-southeast-1 region within AWS. If you want to run it within any other region, make changes accordingly within the Terraform code

- Check if you getting errors while running this Terraform code due to AWS defined soft limits or hard limits within your AWS account. Please work with your AWS support team to resolve limit constraints

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | Latest Version |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | data source |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | data source |
| [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | data source |
| [aws_db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | data source |

## Inputs

- Database password 

## Outputs

| Name | Description |
|------|-------------|
| <a name="rds_hostname"></a> [rds_hostname](#output\_rds\_hostname) | RDS instance hostname |
| <a name="rds_port"></a> [rds_port](#output\_rds\_port) | RDS instance port |
| <a name="rds_username"></a> [rds_username](#output\_rds\_username) | RDS instance root username |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->