provider "aws" {
  region = var.region
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "postgresql" {
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.vpc_subnets.ids
  tags = var.db_subnet_group_tag
}

resource "aws_security_group" "rds" {
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

resource "aws_db_parameter_group" "postgresql" {
  name   = var.db_parameter_group_name
  family = var.db_parameter_group_family

 dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
}

resource "aws_db_instance" "postgresql" {
  identifier             = var.aws_database_instance_identifier
  instance_class         = var.aws_database_instance_class
  allocated_storage      = var.aws_database_allocated_storage
  engine                 = "postgres"
  engine_version         = var.aws_database_engine_version
  username               = var.aws_database_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.postgresql.name
  publicly_accessible    = var.aws_database_publicly_accessible
  skip_final_snapshot    = var.aws_database_skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.postgresql.name
  vpc_security_group_ids = [aws_security_group.rds.id]
}
