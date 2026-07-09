
variable "use_aurora" { type = bool }
variable "identifier" { type = string }
variable "db_name" { type = string }
variable "username" { type = string }
variable "password" { type = string; sensitive = true }
variable "vpc_id" { type = string }
variable "vpc_cidr_block" { type = string }
variable "subnet_ids" { type = list(string) }
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "parameter_group_family" { type = string }
variable "instance_class" { type = string }
variable "multi_az" { type = bool }
variable "db_port" { type = number }
