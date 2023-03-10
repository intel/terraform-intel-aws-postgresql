
locals {

  # Evaluates if a parameter wasn't supplied in the input map (someone didn't want to use it) and returns only the objects that have been configured
  db_parameters = { for parameter, value in lookup(var.db_parameters, var.db_engine, {}) : parameter => value if value != null /* object */ }

  # If create_security_groups is false and security_group_ids is not equal to an empty list then use the list. If those are false then use the generated security group id
  security_group_ids = var.create_security_group == false && var.security_group_ids != [""] ? var.security_group_ids : tolist([aws_security_group.rds[0].id])

  # If skip_final_snapshot is set to false then assemble a string with the prefix-rds_identifier-random_id. dec is used because b64 and id can contain characters that rds does not allow
  snapshot_identifier = var.skip_final_snapshot == false ? "${var.final_snapshot_prefix}${var.rds_identifier}-${random_id.rid.dec}" : ""

  # Determine if the db_username is set. If it is then we will use the value. If not we lookup the db_engine and supply a default for postgres. If the engine is mysql we use a different user for that if it is not equal to any then we pass a null value and error
  db_username = var.db_username != null ? var.db_username : (var.db_engine == "postgres" ? "pgadmin" : (var.db_engine == "mysql" ? "mysqladmin" : null))

  # Flag that checks the values of the variables which are overrides for some basic values when replication is in use. If they are set then those values are used in the RDS resource
  replication_snapshot_bool = var.db_replicate_source_db != null || var.db_snapshot_identifier != null ? true : false

  # Determine if the db_engine is set to mysql. If false then created a list of all the backup strings, if true then create an empty list. This list is referenced to determine the length which acts like a flag for the dynamic block
  restore_point_flag = var.db_engine != "mysql" ? compact([var.db_automated_backup_arn, var.db_use_latest_restore_time, var.db_restore_time, var.db_source_dbi_resource_id, var.db_source_db_instance_id]) : []

  # TODO create a local that evaluates the version of postgres that was specified and only keeps the first 2 digits of the version and appends it to the db_engine. Add conditional logic to do the same for mysql but mysql requires x.x versioning
  # db_parameter_group_family = var.db_engine == "postgres" ? "${var.db_engine}${substr(var.db_engine_version, 0, 2)}" : var.db_engine
}

resource "random_id" "rid" {
  byte_length = 5
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "rds" {
  count      = var.create_subnet_group ? 1 : 0
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.vpc_subnets.ids
  tags       = var.db_subnet_group_tag
}

resource "aws_db_parameter_group" "rds" {
  name   = "${var.db_parameter_group_name}-${random_id.rid.dec}"
  family = var.db_parameter_group_family

  dynamic "parameter" {
    for_each = local.db_parameters
    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true #https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group#create_before_destroy-lifecycle-configuration
  }
}

resource "aws_db_instance" "rds" {
  identifier     = var.rds_identifier
  instance_class = var.instance_class

  # General
  db_name              = var.db_name
  engine               = local.replication_snapshot_bool ? null : var.db_engine
  engine_version       = local.replication_snapshot_bool ? null : var.db_engine_version
  username             = local.replication_snapshot_bool ? null : local.db_username
  password             = local.replication_snapshot_bool ? null : var.db_password
  parameter_group_name = aws_db_parameter_group.rds.name
  option_group_name    = var.db_option_group
  availability_zone    = var.availability_zone
  multi_az             = var.multi_az
  ca_cert_identifier   = var.db_ca_cert_identifier

  # Networking
  publicly_accessible    = var.db_publicly_accessible
  db_subnet_group_name   = var.create_subnet_group ? aws_db_subnet_group.rds[0].name : null
  vpc_security_group_ids = local.security_group_ids
  port                   = var.db_port

  # AD / IAM
  iam_database_authentication_enabled = var.db_iam_authentication
  domain                              = var.db_domain
  domain_iam_role_name                = var.db_domain_iam_role
  custom_iam_instance_profile         = var.db_custom_iam_profile

  # Storage
  storage_type          = var.db_iops > 0 ? "io1" : var.db_storage_type # Swap to io1 if iops are greater than 0 since AWS doesn't support it on GP2
  allocated_storage     = local.replication_snapshot_bool ? null : var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  iops                  = var.db_iops
  storage_encrypted     = var.db_encryption
  kms_key_id            = var.kms_key_id

  # Backups / Maintenance
  maintenance_window          = var.db_maintenance_window
  backup_window               = var.db_backup_window
  backup_retention_period     = var.db_backup_retention_period
  allow_major_version_upgrade = var.auto_major_version_upgrades
  auto_minor_version_upgrade  = var.auto_minor_version_upgrades
  apply_immediately           = var.db_apply_immediately

  # Snapshots / Deletion
  snapshot_identifier       = var.db_snapshot_identifier
  deletion_protection       = var.db_deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.replication_snapshot_bool ? null : local.snapshot_identifier

  # Monitoring
  monitoring_interval                   = var.db_monitoring_interval
  monitoring_role_arn                   = var.db_monitoring_role_arn
  performance_insights_enabled          = var.db_performance_insights
  performance_insights_kms_key_id       = var.db_performance_insights ? var.db_performance_insights_kms_key_id : null
  performance_insights_retention_period = var.db_performance_insights ? var.db_performance_retention_period : null
  enabled_cloudwatch_logs_exports       = var.db_cloudwatch_logs_export

  # Replication
  replicate_source_db = var.db_replicate_source_db

  # Restore
  # Dynamic block required since non-supported databases using this block core the provider
  dynamic "restore_to_point_in_time" {
    for_each = length(local.restore_point_flag) >= 1 ? { "restore_point" : "" } : {}

    content {
      restore_time                             = var.db_use_latest_restore_time != null ? null : var.db_restore_time
      source_dbi_resource_id                   = var.db_source_dbi_resource_id
      source_db_instance_identifier            = var.db_source_db_instance_id
      use_latest_restorable_time               = var.db_use_latest_restore_time
      source_db_instance_automated_backups_arn = var.db_automated_backup_arn
    }
  }
  # Tags
  tags = var.db_tags



  timeouts {
    create = var.db_timeouts.create
    delete = var.db_timeouts.delete
    update = var.db_timeouts.update
  }
}

# Move to conditional
resource "aws_security_group" "rds" {
  count  = var.create_security_group ? 1 : 0
  name   = var.aws_security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = var.rds_security_group_tag

  lifecycle {
    # Check that quad 0 isn't allowed inbound to the db_instance
    precondition {
      condition     = !contains(var.ingress_cidr_blocks, "0.0.0.0/0")
      error_message = "var.ingress_cidr_blocks should not be set to [\"0.0.0.0/0\"] as this is unsafe. Please scope the range to your IP address or a subnet you own. Eg [\"184.96.249.192/32\"]."
    }
  }
}

