variable "source_bucket_name" {
  type = string
  description = "source bucket name"
}

variable "publish_bucket_name" {
  type = string
  description = "publish bucket name"
}

variable "lambda_repo_git_link" {
  type = string
  description = "link to the lambda repository in github"
}

variable "codebuild_proj_name" {
  type = string
}

variable "codebuild_env_compute_type" {
  type = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_env_image" {
  type = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
}

variable "codebuild_env_type" {
  type = string
  default = "LINUX_CONTAINER"
}

variable "lambda_role_name" {
  type = string
  default = "lambda execution role"
}

variable "lambda_role_policy_name" {
  type = string
  default = "lambda role policy name"
}

variable "lambda_layers_arns" {
  type = list(string)
  description = "list of layers to attach to lambda"
}

variable "lambda_func_name" {
  type = string
  description = "lambda function name"
}
