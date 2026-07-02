output "bucket_url" { value = aws_s3_bucket.this.bucket_regional_domain_name }
output "table_name" { value = aws_dynamodb_table.this.name }
