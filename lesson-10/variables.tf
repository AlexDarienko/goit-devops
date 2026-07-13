variable "bucket_name" {
  description = "S3 bucket name for state"
  type        = string
  default     = "alex-devops-tfstate-l10"
}

variable "dynamo_table_name" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "terraform-locks-l10"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets list"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Private subnets list"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  description = "AZs list"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "lesson-10-vpc"
}

variable "ecr_name" {
  description = "ECR repo name"
  type        = string
  default     = "lesson-10-ecr"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "lesson-10-eks"
}

variable "db_password" {
  description = "Database admin password (passed via tfvars)"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB for RDS"
  type        = number
  default     = 20
}
