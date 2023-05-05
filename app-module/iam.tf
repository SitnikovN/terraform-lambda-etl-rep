resource "aws_iam_role" "terraform_lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  policy_arn = aws_iam_policy.terraform_lambda_policy.arn
  role       = aws_iam_role.terraform_lambda_role.name
}

resource "aws_iam_policy" "terraform_lambda_policy" {
  name = var.lambda_role_policy_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
        "s3:GetObject",
        "s3:ListObjectsV2",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource =  [aws_s3_bucket.terraform-source-bucket.arn,
              "${aws_s3_bucket.terraform-source-bucket.arn}/*"]
      },
      {
        Action = [
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource =  "${aws_s3_bucket.terraform-publish-bucket.arn}/*"
      },
    ]
  })
}


resource "aws_iam_role" "terraform_codebuild_role" {
  name = "terraform_codebuild_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "example_codebuild_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
            {
            "Effect": "Allow",
            "Action": [
                "lambda:AddPermission",
                "lambda:RemovePermission",
                "lambda:CreateAlias",
                "lambda:UpdateAlias",
                "lambda:DeleteAlias",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:PutFunctionConcurrency",
                "lambda:DeleteFunctionConcurrency",
                "lambda:PublishVersion"
            ],
            "Resource": aws_lambda_function.terraform-demo-func.arn
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_role_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.terraform_codebuild_role.name
}