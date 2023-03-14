terraform {
  backend "s3" {
    bucket = "minaiacbucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformIaC"
  }
}