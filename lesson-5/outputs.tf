# S3 / DynamoDB Outputs
output "backend_bucket_name" { value = module.s3_backend.bucket_name }
output "backend_bucket_arn" { value = module.s3_backend.bucket_arn }
output "backend_bucket_region" { value = module.s3_backend.bucket_region }
output "dynamodb_table_name" { value = module.s3_backend.dynamodb_table_name }
output "dynamodb_table_arn" { value = module.s3_backend.dynamodb_table_arn }

# VPC Outputs
output "vpc_id" { value = module.vpc.vpc_id }
output "vpc_cidr_block" { value = module.vpc.vpc_cidr_block }
output "public_subnet_ids" { value = module.vpc.public_subnet_ids }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
output "internet_gateway_id" { value = module.vpc.internet_gateway_id }
output "nat_gateway_ids" { value = module.vpc.nat_gateway_ids }
output "public_route_table_id" { value = module.vpc.public_route_table_id }
output "private_route_table_ids" { value = module.vpc.private_route_table_ids }

# ECR Outputs
output "ecr_repository_url" { value = module.ecr.repository_url }
output "ecr_repository_arn" { value = module.ecr.repository_arn }
output "ecr_repository_name" { value = module.ecr.repository_name }
