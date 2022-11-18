########################
####     General    ####
########################

output "db_hostname" {
  description = "Database instance hostname."
  value       = aws_db_instance.rds.address
}

output "db_endpoint" {
  description = "Connection endpoint for the database instance that has been created."
  value       = aws_db_instance.rds.endpoint
}

output "db_port" {
  description = "Database instance port."
  value       = aws_db_instance.rds.port
}

output "db_instance_id" {
  description = "RDS instance ID."
  value       = aws_db_instance.rds.id
}

output "db_engine" {
  description = "Database instance engine that was configured."
  value       = aws_db_instance.rds.engine
}

output "db_name" {
  description = "Name of the database that was created (if specified) during instance creation."
  value       = aws_db_instance.rds.db_name
}

output "db_status" {
  description = "Status of the database instance that was created."
  value       = aws_db_instance.rds.status
}

output "db_parameter_group" {
  description = "Parameter group that was created"
  value       = aws_db_parameter_group.rds.name
}

output "instance_class" {
  description = "Instance class in use for the database instance that was created."
  value       = aws_db_instance.rds.instance_class
}

output "db_hosted_zone_id" {
  description = "Hosted zone ID for the database instance."
  value       = aws_db_instance.rds.hosted_zone_id
}

output "db_arn" {
  description = "ARN of the database instance."
  value       = aws_db_instance.rds.arn
}

output "db_maintenance_window" {
  description = "Maintainence window for the database instance."
  value       = aws_db_instance.rds.maintenance_window
}

output "db_subnet_group" {
  description = "Name of the subnet group that is associated with the database instance."
  value       = aws_db_instance.rds.db_subnet_group_name
}

output "db_engine_version_actual" {
  description = "Running engine version of the database (full version number)"
  value       = aws_db_instance.rds.engine_version_actual
}

########################
#### Authentication ####
########################

output "db_username" {
  description = "Database instance master username."
  value       = aws_db_instance.rds.username
  sensitive   = true
}

output "db_password" {
  description = "Database instance master password."
  value       = aws_db_instance.rds.password
  sensitive   = true
}

output "db_iam_auth_enabled" {
  description = "Flag that specifies if iam authenticaiton is enabled on the database"
  value       = aws_db_instance.rds.iam_database_authentication_enabled
}

output "db_domain_iam_role" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service."
  value       = aws_db_instance.rds.iam_database_authentication_enabled
}

output "db_custom_iam_profile" {
  description = "The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance."
  value       = aws_db_instance.rds.custom_iam_instance_profile
}

########################
####    Storage     ####
########################

output "db_allocated_storage" {
  description = "Storage that was allocated to the instance when it configured."
  value       = aws_db_instance.rds.allocated_storage
}

output "db_max_allocated_storage" {
  description = "Maximum storage allocation that is configured on the database instance."
  value       = aws_db_instance.rds.max_allocated_storage
}

output "db_iops" {
  description = "Database instance iops that was configured."
  value       = aws_db_instance.rds.iops
}

output "db_storage_type" {
  description = "Storage type that is configured on the database instance."
  value       = aws_db_instance.rds.storage_type
}

output "db_encryption" {
  description = "Flag that indicates if storage encryption is enabled."
  value       = aws_db_instance.rds.storage_encrypted
}

########################
####    Monitoring  ####
########################
output "db_monitoring_interval" {
  description = "Monitoring interval configuration."
  value       = aws_db_instance.rds.monitoring_interval
}

output "db_performance_insights" {
  description = "Flag that indiciates if Performance Insights is enabled."
  value       = aws_db_instance.rds.performance_insights_enabled
}

output "db_performance_insights_kms_key_id" {
  description = "ARN of the KMS key that Performance Insights is utilizing (if enabled)."
  value       = aws_db_instance.rds.performance_insights_kms_key_id
}

output "db_performance_insights_retention_period" {
  description = "Data retention period for Performance Insights (if enabled)."
  value       = aws_db_instance.rds.performance_insights_retention_period
}

########################
####    Security    ####
########################

output "db_security_group_ids" {
  description = "Security Group IDs that were associated with the database instance."
  value       = aws_db_instance.rds.vpc_security_group_ids
}

output "db_security_group" {
  description = "Security Group that was created (if specified) during the run."
  value       = try(aws_security_group.rds[0], "")
}

output "db_kms_key_id" {
  description = "KMS key that is configured on the database instance if storage encryption is enabled."
  value       = aws_db_instance.rds.kms_key_id
}

output "db_ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance."
  value       = aws_db_instance.rds.ca_cert_identifier
}

########################
####     Backups    ####
########################

output "db_latest_restore_time" {
  description = "Latest available restorable time for the database instance."
  value       = aws_db_instance.rds.latest_restorable_time
}

output "db_backup_window" {
  description = "Configured backup window for the database instance."
  value       = aws_db_instance.rds.backup_window
}

output "db_backup_retention" {
  description = "Number of configured backups to keep for the database instance."
  value       = aws_db_instance.rds.backup_retention_period
}

output "db_delete_automated_backups" {
  description = "Flag that specifies if automated backups are deleted."
  value       = aws_db_instance.rds.delete_automated_backups
}

output "db_final_snapshot_identifier" {
  description = "Final snapshot identifier for the database instance."
  value       = aws_db_instance.rds.final_snapshot_identifier
}

########################
####     Restore    ####
########################

output "db_restore_time" {
  description = "The date and time to restore from."
  value       = try(aws_db_instance.rds.restore_to_point_in_time[0].restore_time, "")
}

output "db_source_dbi_resource_id" {
  description = "The resource ID of the source DB instance from which to restore."
  value       = try(aws_db_instance.rds.restore_to_point_in_time[0].source_dbi_resource_id, "")
}

output "db_source_db_instance_id" {
  description = "The identifier of the source DB instance from which to restore."
  value       = try(aws_db_instance.rds.restore_to_point_in_time[0].source_db_instance_identifier, "")
}

output "db_automated_backup_arn" {
  description = "The ARN of the automated backup from which to restore."
  value       = try(aws_db_instance.rds.restore_to_point_in_time[0].source_db_instance_automated_backups_arn, "")
}
