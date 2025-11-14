terraform {
  backend "s3" {
    bucket         = "test-django-app-lesson-8-9"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
