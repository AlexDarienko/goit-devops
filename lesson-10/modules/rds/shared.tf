
resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = { Name = "${var.identifier}-subnet-group" }
}

resource "aws_security_group" "this" {
  name   = "${var.identifier}-sg"
  vpc_id = var.vpc_id
  ingress { from_port = var.db_port; to_port = var.db_port; protocol = "tcp"; cidr_blocks = [var.vpc_cidr_block] }
}
