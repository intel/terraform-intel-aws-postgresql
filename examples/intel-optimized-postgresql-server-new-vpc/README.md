# intel-optimized-postgresql-server

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
