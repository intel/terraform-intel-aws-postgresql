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
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnets.vpc_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_database_allocated_storage"></a> [aws\_database\_allocated\_storage](#input\_aws\_database\_allocated\_storage) | allocated storage for aws database instance | `number` | `20` | no |
| <a name="input_aws_database_engine_version"></a> [aws\_database\_engine\_version](#input\_aws\_database\_engine\_version) | database engine version for aws database instance | `string` | `"13.7"` | no |
| <a name="input_aws_database_instance_class"></a> [aws\_database\_instance\_class](#input\_aws\_database\_instance\_class) | instance class for aws database instance | `string` | `"db.m6i.large"` | no |
| <a name="input_aws_database_instance_identifier"></a> [aws\_database\_instance\_identifier](#input\_aws\_database\_instance\_identifier) | identifier for aws database instance | `string` | `"postgresql"` | no |
| <a name="input_aws_database_publicly_accessible"></a> [aws\_database\_publicly\_accessible](#input\_aws\_database\_publicly\_accessible) | flag to indicate whether database will be publicly accessible | `bool` | `false` | no |
| <a name="input_aws_database_skip_final_snapshot"></a> [aws\_database\_skip\_final\_snapshot](#input\_aws\_database\_skip\_final\_snapshot) | flag to indicate whether final snapshot will be skipped upon database termination | `bool` | `true` | no |
| <a name="input_aws_database_username"></a> [aws\_database\_username](#input\_aws\_database\_username) | database username for aws database instance | `string` | `"pgsql"` | no |
| <a name="input_aws_security_group_name"></a> [aws\_security\_group\_name](#input\_aws\_security\_group\_name) | security group name for the rds | `string` | `"postgresql_rds"` | no |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | family for db parameter group | `string` | `"postgres13"` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | name for db parameter group | `string` | `"postgresql"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS root user password | `any` | n/a | yes |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | db subnet group name | `string` | `"postgresql"` | no |
| <a name="input_db_subnet_group_tag"></a> [db\_subnet\_group\_tag](#input\_db\_subnet\_group\_tag) | tag for db subnet group | `map(string)` | <pre>{<br>  "Name": "Postgresql"<br>}</pre> | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | egress cidr block for rds security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_from_port"></a> [egress\_from\_port](#input\_egress\_from\_port) | egress from port for rds security group | `number` | `5432` | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | egress protocol for rds security group | `string` | `"tcp"` | no |
| <a name="input_egress_to_port"></a> [egress\_to\_port](#input\_egress\_to\_port) | egress from port for rds security group | `number` | `5432` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | ingress cidr block for rds security group | `list(string)` | <pre>[<br>  "192.55.54.51/32"<br>]</pre> | no |
| <a name="input_ingress_from_port"></a> [ingress\_from\_port](#input\_ingress\_from\_port) | ingress from port for rds security group | `number` | `5432` | no |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | ingress protocol for rds security group | `string` | `"tcp"` | no |
| <a name="input_ingress_to_port"></a> [ingress\_to\_port](#input\_ingress\_to\_port) | ingress from port for rds security group | `number` | `5432` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameter maps to apply | `list(map(string))` | <pre>[<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_connections",<br>    "value": 256<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "huge_pages",<br>    "value": "on"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "shared_buffers",<br>    "value": "{DBInstanceClassMemory*3/32768}"<br>  },<br>  {<br>    "name": "temp_buffers",<br>    "value": 524288<br>  },<br>  {<br>    "name": "work_mem",<br>    "value": 4194304<br>  },<br>  {<br>    "name": "maintenance_work_mem",<br>    "value": 524288<br>  },<br>  {<br>    "name": "autovacuum_work_mem",<br>    "value": -1<br>  },<br>  {<br>    "name": "max_stack_depth",<br>    "value": 7168<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_files_per_process",<br>    "value": 4000<br>  },<br>  {<br>    "name": "effective_io_concurrency",<br>    "value": 32<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_worker_processes",<br>    "value": "{DBInstanceVCPU}"<br>  },<br>  {<br>    "name": "synchronous_commit",<br>    "value": "off"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "wal_buffers",<br>    "value": -1<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_wal_senders",<br>    "value": 5<br>  },<br>  {<br>    "name": "timezone",<br>    "value": "UTC"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_locks_per_transaction",<br>    "value": 64<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "max_pred_locks_per_transaction",<br>    "value": 64<br>  },<br>  {<br>    "name": "min_wal_size",<br>    "value": 256<br>  },<br>  {<br>    "name": "max_wal_size",<br>    "value": 512<br>  },<br>  {<br>    "name": "checkpoint_completion_target",<br>    "value": 0.9<br>  },<br>  {<br>    "name": "checkpoint_warning",<br>    "value": 3600<br>  },<br>  {<br>    "name": "random_page_cost",<br>    "value": 1.1<br>  },<br>  {<br>    "name": "cpu_tuple_cost",<br>    "value": 0.03<br>  },<br>  {<br>    "name": "effective_cache_size",<br>    "value": 45875200<br>  },<br>  {<br>    "name": "autovacuum",<br>    "value": 1<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "autovacuum_max_workers",<br>    "value": 10<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "autovacuum_freeze_max_age",<br>    "value": 750000000<br>  },<br>  {<br>    "name": "autovacuum_vacuum_cost_limit",<br>    "value": 3000<br>  },<br>  {<br>    "name": "vacuum_freeze_min_age",<br>    "value": 10000000<br>  }<br>]</pre> | no |
| <a name="input_rds_security_group_tag"></a> [rds\_security\_group\_tag](#input\_rds\_security\_group\_tag) | tag for rds security group | `map(string)` | <pre>{<br>  "Name": "postgresql_rds"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID within which the database resource will be created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_hostname"></a> [rds\_hostname](#output\_rds\_hostname) | RDS instance hostname |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | RDS instance port |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | RDS instance root username |
<!-- END_TF_DOCS -->
