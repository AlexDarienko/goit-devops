output "bucket_name" { value = aws_s3_bucket.this.id }
output "bucket_arn" { value = aws_s3_bucket.this.arn }
output "bucket_region" { value = aws_s3_bucket.this.region }
output "dynamodb_table_name" { value = aws_dynamodb_table.this.id }
output "dynamodb_table_arn" { value = aws_dynamodb_table.this.arn }
