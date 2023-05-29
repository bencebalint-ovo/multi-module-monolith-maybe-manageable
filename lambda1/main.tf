data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "dist/build_function_zip"
  output_path = "dist/function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "lambda1"
  role          = aws_iam_role.iam_for_lambda.arn

  filename         = "dist/function.zip"
  handler          = "lambda_handler.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
