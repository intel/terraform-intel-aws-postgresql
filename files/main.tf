resource "aws_db_instance" "tf-postgresql" {
    identifier                            = "tf-postgresql"
    availability_zone                     = "us-east-1a"
    engine                                = "postgres"
    engine_version                        = "13.4"
    instance_class                        = "${var.instance_type}"
    multi_az                              = false
    parameter_group_name                  = "${aws_db_parameter_group.tf-postgresql-parameter-group.name}"
    publicly_accessible                   = true
    storage_type                          = "${var.storage_type}"
    allocated_storage                     = "${var.storage_gb}"
    iops                                  = "${var.storage_iops}"
    username                              = "${var.username}"
    password                              = "${var.password}"
    skip_final_snapshot                   = true
    apply_immediately                     = true
    
}