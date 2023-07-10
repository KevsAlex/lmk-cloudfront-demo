#resource "aws_lambda_function" "notification-event" {
#
#  function_name = "lambda-${var.app-name}-notification-event-${var.environment}"
#
#  s3_bucket = aws_s3_bucket.s3-lambda.id
#  s3_key    = "lambda-${var.app-name}-notification-event-${var.environment}/lambda.zip"
#
#  runtime = "nodejs14.x"
#  handler = "index.handler"
#  timeout = 30
#  //source_code_hash = each.value["aws_s3_bucket_object"]["etag"]
#  role    = aws_iam_role.role-lambda-notification.arn
#
#  environment {
#    variables = {
#      TEAMS_WEBHOOK_URL = "https://neology.webhook.office.com/webhookb2/dc7e3a29-9187-48a5-a705-a9820fa9f7e2@01a7f7dd-7222-4615-80f6-dddb58e158ef/IncomingWebhook/cd9fe82c69634b11989acfdce6b58f6e/a7d3b1a5-6059-4ee9-a0b4-052070bec82a"
#    }
#  }
#
#
#  depends_on = [
#
#    aws_s3_object.lambda_code,
#    aws_s3_object.lambda_code_hash
#  ]
#
#}
#
#resource "aws_s3_bucket" s3-lambda {
#  bucket = "${var.app-name}-lambda-notificatons-${var.environment}"
#  tags = {
#    Environment = var.environment
#  }
#}
#

#resource "aws_lambda_function" "omnia-pipeline-notification-event" {
#
#  function_name = "lambda-omnia-pipeline-notification-event-${var.environment}"
#
#  s3_bucket = aws_s3_bucket.s3-lambda.bucket
#  s3_key    = "lambda-omnia-pipeline-notification-event-${var.environment}/lambda.zip"
#
#  runtime = "nodejs14.x"
#  handler = "index.handler"
#  timeout = 30
#  //source_code_hash = each.value["aws_s3_bucket_object"]["etag"]
#  role    = aws_iam_role.role-lambda-notification.arn
#
#  depends_on = [
#
#    aws_s3_object.lambda_code,
#    aws_s3_object.lambda_code_hash
#  ]
#
#}
#

#resource "aws_s3_object" "lambda_code" {
#
#  bucket                 = aws_s3_bucket.s3-lambda.id
#  key                    = "lambda-${var.app-name}-notification-event-${var.environment}/lambda.zip"
#  acl                    = "private"
#  server_side_encryption = "aws:kms"
#  source                 = data.archive_file.source.output_path
#
#}
#
#resource "aws_s3_object" "lambda_code_hash" {
#
#  bucket                 = aws_s3_bucket.s3-lambda.id
#  key                    = "lambda-${var.app-name}-notification-event-${var.environment}/lambda.zip.base64sha256"
#  acl                    = "private"
#  server_side_encryption = "aws:kms"
#  source                 = data.archive_file.source.output_path
#
#}
#
#data archive_file source {
#  type        = "zip"
#  source_file = "${path.module}/lambdaCode/index.js"
#  output_path = "${path.module}/lambdaCode/lambda.zip"
#}
#
#


#resource aws_iam_role role-lambda-notification {
#  name = "role-omnia-lambda-notification-${var.environment}"
#
#  assume_role_policy = jsonencode({
#    Version   = "2012-10-17"
#    Statement = [
#      {
#        Action    = "sts:AssumeRole"
#        Effect    = "Allow"
#        Sid       = ""
#        Principal = {
#          Service = "lambda.amazonaws.com"
#        }
#      }
#    ]
#  })
#
#  managed_policy_arns = [
#    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
#    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
#    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
#    #aws_iam_policy.allowinvoke.arn
#  ]
#}

#resource "aws_lambda_permission" "with_sns" {
#  statement_id  = "AllowExecutionFromSNS"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.notification-event.function_name
#  principal     = "sns.amazonaws.com"
#  source_arn    = aws_sns_topic.pipeline-notifications.arn
#}

#resource "aws_iam_policy" "allowinvoke" {
#
#  tags        = {}
#  tags_all    = {}
#  name        = "policie-allow-invoke-sns"
#  path        = "/"
#  description = "Allow be invoked"
#
#  policy = jsonencode({
#    Version   = "2012-10-17"
#    Statement = [
#      {
#        //"Sid": "test-sns",
#        "Effect": "Allow",
#        "Principal": {
#          "Service": "sns.amazonaws.com"
#        },
#        "Action": "lambda:InvokeFunction",
#        "Resource": "*"//"arn:aws:lambda:us-east-1:694318308046:function:lambda-nride-notification-event-staging",
#        #"Condition": {
#        #  "ArnLike": {
#        #    "AWS:SourceArn": "arn:aws:sns:us-east-1:694318308046:pipeline-notifications:92d1e799-1ad9-43b3-bc13-25e706d2b05"
#        #  }
#        #}
#      }
#    ]
#  })
#}