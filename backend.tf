terraform {
  backend "s3" {
    bucket         = "test-bb-anatolii-b-009"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

