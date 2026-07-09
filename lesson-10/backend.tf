# terraform {
#   backend "s3" {
#     bucket         = "alex-devops-tfstate-l10"
#     key            = "lesson-10/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks-l10"
#     encrypt        = true
#   }
# }
