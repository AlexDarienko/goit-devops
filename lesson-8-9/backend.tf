# terraform {
#   backend "s3" {
#     bucket         = "alex-devops-tfstate-l8"
#     key            = "lesson-8/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks-l8"
#     encrypt        = true
#   }
# }
