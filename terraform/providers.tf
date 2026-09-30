provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "devops-capstone"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}