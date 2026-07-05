resource "aws_vpc" "this" { cidr_block = var.vpc_cidr_block; enable_dns_hostnames = true; enable_dns_support = true; tags = { Name = var.vpc_name } }
resource "aws_subnet" "public" { count = length(var.public_subnets); vpc_id = aws_vpc.this.id; cidr_block = var.public_subnets[count.index]; availability_zone = var.availability_zones[count.index]; map_public_ip_on_launch = true; tags = { Name = "${var.vpc_name}-pub-${count.index}" } }
resource "aws_subnet" "private" { count = length(var.private_subnets); vpc_id = aws_vpc.this.id; cidr_block = var.private_subnets[count.index]; availability_zone = var.availability_zones[count.index]; tags = { Name = "${var.vpc_name}-priv-${count.index}" } }
resource "aws_internet_gateway" "this" { vpc_id = aws_vpc.this.id }
resource "aws_eip" "nat" { domain = "vpc" }
resource "aws_nat_gateway" "this" { allocation_id = aws_eip.nat.id; subnet_id = aws_subnet.public[0].id }
