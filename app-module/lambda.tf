
data "archive_file" "lambda" {
  type        = "zip"
  source_file     = "lambda_handler.py"
  output_path = "lambda_handler_func.zip"
}

resource "aws_lambda_function" "terraform-demo-func" {
  function_name = "terraform-demo-func"
  filename = "lambda_handler_func.zip"
  handler = "lambda_handler.lambda_handler"
  runtime = "python3.9"
  role = aws_iam_role.terraform_lambda_role.arn
  layers = var.lambda_layers_arns
}
