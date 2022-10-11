resource "aws_db_parameter_group" "tf-postgresql-parameter-group" {
  name   = "tf-postgresql-parameter-group"
  family = "postgres13"
  
  parameter {
    name  = "max_connections"
    value = 256
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "huge_pages"
    value = "on"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "shared_buffers"
    value = "{DBInstanceClassMemory*3/32768}"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "temp_buffers"
    value = 4096 * 1024 / 8
  }
  parameter {
    name  = "work_mem"
    value = 4096 *1024
  }
  parameter {
    name  = "maintenance_work_mem"
    value = 512 * 1024
  }
  parameter {
    name  = "autovacuum_work_mem"
    value = -1
  }
  parameter {
    name  = "max_stack_depth"
    value = 7 * 1024
  }
  parameter {
    name  = "max_files_per_process"
    value = 4000
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "effective_io_concurrency"
    value = 32
  }
  parameter {
    name  = "max_worker_processes"
    value = "{DBInstanceVCPU}"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "synchronous_commit"
    value = "off"
  }
  parameter {
    name  = "wal_buffers"
    value = -1
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "max_wal_senders"
    value = 5
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "timezone"
    value = "UTC"
  }
  parameter {
    name  = "max_locks_per_transaction"
    value = 64
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "max_pred_locks_per_transaction"
    value = 64
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "min_wal_size"
    value = 256
  }
  parameter {
    name  = "max_wal_size"
    value = 512
  }
  parameter {
    name  = "checkpoint_completion_target"
    value = 0.9
  }
  parameter {
    name  = "checkpoint_warning"
    value = 1 * 60 * 60
  }
  parameter {
    name  = "random_page_cost"
    value = 1.1
  }
  parameter {
    name  = "cpu_tuple_cost"
    value = 0.03
  }
  parameter {
    name  = "effective_cache_size"
    value = 350 * 1024 * 1024 / 8
  }
  parameter {
    name  = "autovacuum"
    value = 1
  }
  parameter {
    name  = "autovacuum_max_workers"
    value = 10
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "autovacuum_freeze_max_age"
    value = 750000000
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "autovacuum_vacuum_cost_limit"
    value = 3000
  }
  parameter {
    name  = "vacuum_freeze_min_age"
    value = 10000000
  }


}