variable "bucket_name" { default = "alex-devops-tfstate-l10"; type = string; description = "S3 bucket name for state" }
variable "dynamo_table_name" { default = "terraform-locks-l10"; type = string; description = "DynamoDB table for state locking" }
variable "vpc_cidr_block" { default = "10.0.0.0/16"; type = string; description = "VPC CIDR block" }
variable "public_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]; type = list(string); description = "Public subnets list" }
variable "private_subnets" { default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]; type = list(string); description = "Private subnets list" }
variable "availability_zones" { default = ["us-west-2a", "us-west-2b", "us-west-2c"]; type = list(string); description = "AZs list" }
variable "vpc_name" { default = "lesson-10-vpc"; type = string; description = "Name of the VPC" }
variable "ecr_name" { default = "lesson-10-ecr"; type = string; description = "ECR repo name" }
variable "cluster_name" { default = "lesson-10-eks"; type = string; description = "EKS cluster name" }

# Змінні для RDS
variable "db_password" { type = string; sensitive = true; description = "Database admin password (passed via tfvars)" }
variable "db_allocated_storage" { default = 20; type = number; description = "Allocated storage in GB for RDS" }
