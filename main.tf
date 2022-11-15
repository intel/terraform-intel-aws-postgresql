locals {
  security_group_ids        = var.create_security_group == false && var.security_group_ids != [""] ? var.security_group_ids : tolist([aws_security_group.rds[0].id])
  snapshot_identifier       = var.skip_final_snapshot == false ? "${var.final_snapshot_prefix}${var.rds_identifier}-${random_id.rid.id}" : ""
  db_username               = var.db_username != null ? var.db_username : (var.db_engine == "postgres" ? "pgadmin" : (var.db_engine == "mysql" ? "mysqladmin" : null))
  replication_snapshot_bool = var.db_replicate_source_db != null || var.db_snapshot_identifier != null ? true : false

  restore_point_flag = compact([var.db_automated_backup_arn, var.db_snapshot_identifier, var.db_use_latest_restore_time, var.db_restore_time, var.db_source_dbi_resource_id, var.db_source_db_instance_id])
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
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.vpc_subnets.ids
  tags       = var.db_subnet_group_tag
}

resource "aws_db_parameter_group" "rds" {
  name   = var.db_parameter_group_name
  family = var.db_parameter_group_family

  dynamic "parameter" {
    for_each = lookup(var.db_parameters, var.db_engine, {})
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
  identifier     = var.aws_database_instance_identifier
  instance_class = var.instance_class

  # General
  db_name              = var.db_name
  engine               = local.replication_snapshot_bool ? null : var.db_engine
  engine_version       = var.db_engine_version
  username             = local.replication_snapshot_bool ? null : local.db_username
  password             = local.replication_snapshot_bool ? null : var.db_password
  parameter_group_name = aws_db_parameter_group.rds.name
  option_group_name    = var.db_option_group
  availability_zone    = var.availability_zone
  multi_az             = var.multi_az

  # Networking
  publicly_accessible    = var.db_publicly_accessible
  db_subnet_group_name   = aws_db_subnet_group.rds.name
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
  final_snapshot_identifier = local.snapshot_identifier

  # Monitoring
  monitoring_interval                   = var.db_monitoring_interval
  monitoring_role_arn                   = var.db_monitoring_role_arn
  performance_insights_enabled          = var.db_performance_insights
  performance_insights_kms_key_id       = var.db_performance_insights ? var.db_performance_retention_period : null
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
}
