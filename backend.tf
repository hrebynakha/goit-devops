terraform {
  backend "s3" {
    bucket         = "test-django-app-lesson-7"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
