variable "region" {
  default     = "ap-southeast-1"
  description = "AWS region"
}

variable vpc_name {
  description = "name of the vpc that will be created. Other resources will be creatred within this vpc"
  type = string
  default = "postgresql"
}

variable vpc_cidr {
  description = "cidr range of the vpc"
  type = string
  default = "10.0.0.0/16"
}

variable vpc_private_subnets {
  description = "private subnets of the vpc"
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable vpc_enable_dns_hostname {
  description = "flag to indicate if dns hostname will be enabled for vpc"
  type = bool
  default = true
}

variable vpc_enable_dns_support {
  description = "flag to indicate if dns support will be enabled for vpc"
  type = bool
  default = true
}

variable db_subnet_group_name {
  description = "db subnet group name"
  type = string
  default = "postgresql"
}

variable db_subnet_group_tag {
  description = "tag for db subnet group"
  type = map(string)
  default = {
  "Name" = "Postgresql"
}
}

variable aws_security_group_name {
  description = "security group name for the rds"
  type = string
  default = "postgresql_rds"
}

variable ingress_from_port {
  description = "ingress from port for rds security group"
  type = number
  default = 5432
}

variable ingress_to_port {
  description = "ingress from port for rds security group"
  type = number
  default = 5431
}

variable ingress_protocol {
  description = "ingress protocol for rds security group"
  type = string
  default = "tcp"
}

variable ingress_cidr_blocks {
  description = "ingress cidr block for rds security group"
  type = list(string)
  default = ["192.55.54.51/32"]
}

variable egress_from_port {
  description = "egress from port for rds security group"
  type = number
  default = 5432
}

variable egress_to_port {
  description = "egress from port for rds security group"
  type = number
  default = 5432
}

variable egress_protocol {
  description = "egress protocol for rds security group"
  type = string
  default = "tcp"
}

variable egress_cidr_blocks {
  description = "egress cidr block for rds security group"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable rds_security_group_tag {
  description = "tag for rds security group"
  type = map(string)
  default = {
  "Name" = "postgresql_rds"
}
}

variable db_parameter_group_name {
  description = "name for db parameter group"
  type = string
  default = "postgresql"
}

variable db_parameter_group_family {
  description = "family for db parameter group"
  type = string
  default = "postgres13"
}

variable aws_database_instance_identifier {
  description = "identifier for aws database instance"
  type = string
  default = "postgresql"
}

variable aws_database_instance_class {
  description = "instance class for aws database instance"
  type = string
  default = "db.m6i.large"
}

variable aws_database_allocated_storage {
  description = "allocated storage for aws database instance"
  type = number
  default = 20
}

variable aws_database_engine_version {
  description = "database engine version for aws database instance"
  type = string
  default = "13.7"
}

variable aws_database_username {
  description = "database username for aws database instance"
  type = string
  default = "pgsql"
}

variable aws_database_publicly_accessible {
  description = "flag to indicate whether database will be publicly accessible"
  type = bool
  default = false
}

variable aws_database_skip_final_snapshot {
  description = "flag to indicate whether final snapshot will be skipped upon database termination"
  type = bool
  default = true
}

variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = [
     {
    name  = "max_connections"
    value = 256
    apply_method = "pending-reboot"
  },
  {
    name  = "huge_pages"
    value = "on"
    apply_method = "pending-reboot"
  },
  {
    name  = "shared_buffers"
    value = "{DBInstanceClassMemory*3/32768}"
    apply_method = "pending-reboot"
  },
  {
    name  = "temp_buffers"
    value = 4096 * 1024 / 8
  },
  {
    name  = "work_mem"
    value = 4096 *1024
  },
  {
    name  = "maintenance_work_mem"
    value = 512 * 1024
  },
  {
    name  = "autovacuum_work_mem"
    value = -1
  },
  {
    name  = "max_stack_depth"
    value = 7 * 1024
  },
  {
    name  = "max_files_per_process"
    value = 4000
    apply_method = "pending-reboot"
  },
  {
    name  = "effective_io_concurrency"
    value = 32
  },
  {
    name  = "max_worker_processes"
    value = "{DBInstanceVCPU}"
    apply_method = "pending-reboot"
  },
  {
    name  = "synchronous_commit"
    value = "off"
  },
  {
    name  = "wal_buffers"
    value = -1
    apply_method = "pending-reboot"
  },
  {
    name  = "max_wal_senders"
    value = 5
    apply_method = "pending-reboot"
  },
  {
    name  = "timezone"
    value = "UTC"
  },
  {
    name  = "max_locks_per_transaction"
    value = 64
    apply_method = "pending-reboot"
  },
  {
    name  = "max_pred_locks_per_transaction"
    value = 64
    apply_method = "pending-reboot"
  },
  {
    name  = "min_wal_size"
    value = 256
  },
  {
    name  = "max_wal_size"
    value = 512
  },
  {
    name  = "checkpoint_completion_target"
    value = 0.9
  },
  {
    name  = "checkpoint_warning"
    value = 1 * 60 * 60
  },
  {
    name  = "random_page_cost"
    value = 1.1
  },
  {
    name  = "cpu_tuple_cost"
    value = 0.03
  },
  {
    name  = "effective_cache_size"
    value = 350 * 1024 * 1024 / 8
  },
  {
    name  = "autovacuum"
    value = 1
  },
  {
    name  = "autovacuum_max_workers"
    value = 10
    apply_method = "pending-reboot"
  },
  {
    name  = "autovacuum_freeze_max_age"
    value = 750000000
    apply_method = "pending-reboot"
  },
  {
    name  = "autovacuum_vacuum_cost_limit"
    value = 3000
  },
  {
    name  = "vacuum_freeze_min_age"
    value = 10000000
  }
]
}
