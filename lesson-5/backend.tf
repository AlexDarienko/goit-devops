# Після першого успішного terraform apply розкоментуйте цей блок і запустіть terraform init повторно
# terraform {
#   backend "s3" {
#     bucket         = "alex-devops-tfstate-unique-bucket"
#     key            = "lesson-5/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
