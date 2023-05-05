terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "eu-central-1"
  access_key = ""
  secret_key = ""
}

module "app_module" {
  source = "./app-module"
  source_bucket_name      = "terraform-source-demo-bucket"
  publish_bucket_name     = "terraform-publish-demo-bucket"
  lambda_func_name        = "terraform-demo-func"
  lambda_repo_git_link    = "https://github.com/SitnikovN/terraform-proj"
  lambda_role_name        = "demo_terraform_lambda_role"
  lambda_role_policy_name = "demo_terraform_lambda_policy"
  lambda_layers_arns      = ["arn:aws:lambda:eu-central-1:336392948345:layer:AWSSDKPandas-Python39:5"]
  codebuild_proj_name     = "terraform-demo-project"
}
