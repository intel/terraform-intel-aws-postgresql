output "postgres_address" {
  description = "postgres instance hostname"
  value       = module.optimized-postgres-server.db_hostname
}

output "postgres_port" {
  description = "postgres instance port"
  value       = module.optimized-postgres-server.db_port
}

output "postgres_username" {
  description = "postgres instance root username"
  value       = module.optimized-postgres-server.db_username
  sensitive   = true
}

output "postgres_password" {
  description = "postgres instance master password."
  value       = module.optimized-postgres-server.db_password
  sensitive   = true
}

output "postgres_endpoint" {
  value       = module.optimized-postgres-server.db_endpoint
  description = "Connection endpoint for the postgres instance that has been created"
}

output "postgres_engine" {
  value       = module.optimized-postgres-server.db_engine
  description = "Database instance engine that was configured."
}

output "postgres_status" {
  description = "Status of the database instance that was created."
  value       = module.optimized-postgres-server.db_status
}

output "instance_class" {
  description = "Instance class in use for the database instance that was created."
  value       = module.optimized-postgres-server.instance_class
}

output "postgres_allocated_storage" {
  description = "Storage that was allocated to the instance when it configured."
  value       = module.optimized-postgres-server.db_allocated_storage
}

output "postgres_max_allocated_storage" {
  description = "Maximum storage allocation that is configured on the database instance."
  value       = module.optimized-postgres-server.db_max_allocated_storage
}

output "postgres_arn" {
  description = "ARN of the database instance."
  value       = module.optimized-postgres-server.db_arn
}

output "postgres_kms_key_id" {
  description = "KMS key that is configured on the database instance if storage encryption is enabled."
  value       = module.optimized-postgres-server.db_kms_key_id
}

output "postgres_backup_window" {
  description = "Configured backup window for the database instance."
  value       = module.optimized-postgres-server.db_backup_window
}

output "postgres_maintenance_window" {
  description = "Maintainence window for the database instance."
  value       = module.optimized-postgres-server.db_maintenance_window
}

output "postgres_db_name" {
  description = "Name of the database that was created (if specified) during instance creation."
  value       = module.optimized-postgres-server.db_name
}
