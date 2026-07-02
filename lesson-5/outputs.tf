output "s3_backend_bucket_url" {
  value       = module.s3_backend.bucket_url
  description = "URL of the S3 bucket for Terraform state"
}

output "dynamodb_table_name" {
  value       = module.s3_backend.table_name
  description = "Name of the DynamoDB table for state locking"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the created VPC"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "The URL of the ECR repository"
}
