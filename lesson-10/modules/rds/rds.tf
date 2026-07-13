resource "aws_db_parameter_group" "rds" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.identifier}-rds-pg"
  family = var.parameter_group_family
  parameter {
    name         = "max_connections"
    value        = "100"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "log_statement"
    value = "all"
  }
  parameter {
    name  = "work_mem"
    value = "4096"
  }
}

resource "aws_db_instance" "this" {
  count                  = var.use_aurora ? 0 : 1
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  parameter_group_name   = aws_db_parameter_group.rds[0].name
  multi_az               = var.multi_az
  skip_final_snapshot    = true
}
