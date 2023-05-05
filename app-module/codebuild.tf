resource "aws_codebuild_project" "terraform-demo-project" {
  name         = var.codebuild_proj_name
  service_role = aws_iam_role.terraform_codebuild_role.arn

  environment {
    compute_type = var.codebuild_env_compute_type
    image        = var.codebuild_env_image
    type         = var.codebuild_env_type
  }

  artifacts {
    type    = "NO_ARTIFACTS"
  }

  source {
    type            = "GITHUB"
    location        = var.lambda_repo_git_link
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }
}