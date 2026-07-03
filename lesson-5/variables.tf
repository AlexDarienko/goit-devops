variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "alex-devops-tfstate-unique-bucket" # Зміни на своє ім'я
}

variable "dynamo_table_name" {
  type    = string
  default = "terraform-locks"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_name" {
  type    = string
  default = "lesson-5-vpc"
}

variable "ecr_name" {
  type    = string
  default = "lesson-5-ecr"
}
