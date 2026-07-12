
variable "use_aurora" { description = "Flag to determine if Aurora cluster should be created"; type = bool; default = false }
variable "identifier" { description = "The identifier for the RDS instance or cluster"; type = string; default = "my-db" }
variable "db_name" { description = "Name of the database"; type = string; default = "mydb" }
variable "username" { description = "Master username for the database"; type = string; default = "admin" }
variable "password" { description = "Master password for the database"; type = string; sensitive = true; default = "ChangeMe123!" }
variable "vpc_id" { description = "VPC ID where the database will be deployed"; type = string }
variable "vpc_cidr_block" { description = "CIDR block of the VPC for Security Group ingress"; type = string }
variable "subnet_ids" { description = "List of subnet IDs for the DB subnet group"; type = list(string) }
variable "engine" { description = "Database engine (postgres, mysql, aurora-postgresql)"; type = string; default = "postgres" }
variable "engine_version" { description = "Database engine version"; type = string; default = "13.11" }
variable "parameter_group_family" { description = "Family of the DB parameter group"; type = string; default = "postgres13" }
variable "instance_class" { description = "Instance class for the RDS or Aurora instance"; type = string; default = "db.t3.micro" }
variable "multi_az" { description = "Enable Multi-AZ deployment for standard RDS"; type = bool; default = false }
variable "db_port" { description = "Port on which the database accepts connections"; type = number; default = 5432 }
variable "allocated_storage" { description = "Allocated storage in GB for standard RDS"; type = number; default = 20 }
