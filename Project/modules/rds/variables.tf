variable "use_aurora" {}
variable "identifier" {}
variable "db_name" {}
variable "username" {}
variable "password" {
  sensitive = true
}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "subnet_ids" {}
variable "engine" {}
variable "engine_version" {}
variable "parameter_group_family" {}
variable "instance_class" {}
variable "multi_az" {}
variable "db_port" {}
variable "allocated_storage" {}
