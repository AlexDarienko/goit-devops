terraform {
  backend "s3" {
    bucket         = "alex-devops-tfstate-final-v2"
    key            = "final/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks-final-v2"
    encrypt        = true
  }
}
