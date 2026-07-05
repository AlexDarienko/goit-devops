# terraform {
#   backend "s3" {
#     bucket         = "alex-devops-tfstate-lesson7"
#     key            = "lesson-7/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks-l7"
#     encrypt        = true
#   }
# }
