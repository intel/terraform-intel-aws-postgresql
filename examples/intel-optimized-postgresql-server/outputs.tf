output "postgres_address" {
  description = "Postgresql instance hostname"
  value       = module.optimized-postgresql-server.db_hostname
}

output "postgres_port" {
  description = "Postgresql instance port"
  value       = module.optimized-postgresql-server.db_port
}

output "postgres_username" {
  description = "Postgresql instance root username"
  value       = module.optimized-postgresql-server.db_username
  sensitive   = true
}

output "postgres_password" {
  description = "Database instance master password."
  value       = module.optimized-postgresql-server.db_password
  sensitive   = true
}

output "postgres_endpoint" {
  value       = module.optimized-postgresql-server.db_endpoint
  description = "Connection endpoint for the Postgresql instance that has been created"
}

output "postgres_engine" {
  value       = module.optimized-postgresql-server.db_engine
  description = "Database instance engine that was configured."
}