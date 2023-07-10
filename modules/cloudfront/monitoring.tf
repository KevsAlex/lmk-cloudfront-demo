
#resource aws_s3_bucket bhsf-web-portal-canaries {
#  bucket = "s3-bhsf-web-portal-canaries-${local.environment}"
#}
#
#resource "aws_s3_bucket_public_access_block" "bhsf-mobile-canary-config-access" {
#  bucket = aws_s3_bucket.bhsf-web-portal-canaries.id
#  block_public_acls   = true
#  block_public_policy = true
#  restrict_public_buckets = true
#  ignore_public_acls = true
#}
#
#resource aws_iam_role baptisthealth-canary {
#  name = "baptisthealth-canary-${var.env}"
#
#  assume_role_policy = jsonencode({
#    Version   = "2012-10-17"
#    Statement = [
#      {
#        Effect    = "Allow"
#        Sid       = ""
#        Principal = {
#          Service = [
#            "lambda.amazonaws.com",
#            "ec2.amazonaws.com",
#            "states.amazonaws.com"
#          ]
#        }
#        Action = "sts:AssumeRole"
#      }
#    ]
#  })
#  managed_policy_arns = [
#    aws_iam_policy.lambda-create.arn
#  ]
#}
#
#resource "aws_iam_policy" "lambda-create" {
#  name        = "lambda-crew"
#  path        = "/"
#  description = "Custom policy to allow lambda inside a vpc"
#
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        "Effect": "Allow",
#        "Action": [
#          "lambda:CreateFunction",
#        ],
#        "Resource": "*"
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "s3:*Object",
#          "s3:ListBucket",
#          "s3:PutObjectAcl",
#          "s3:GetObjectAcl"
#        ],
#        "Resource": [
#          aws_s3_bucket.bhsf-web-portal-canaries.arn,
#          "${aws_s3_bucket.bhsf-web-portal-canaries.arn}/*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "logs:CreateLogStream",
#          "logs:PutLogEvents",
#          "logs:CreateLogGroup"
#        ],
#        "Resource": [
#          "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "s3:ListAllMyBuckets",
#          "xray:PutTraceSegments"
#        ],
#        "Resource": [
#          "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Resource": "*",
#        "Action": "cloudwatch:PutMetricData",
#        "Condition": {
#          "StringEquals": {
#            "cloudwatch:namespace": "CloudWatchSynthetics"
#          }
#        }
#      }
#    ]
#  })
#}
#
#resource "aws_iam_policy" "chatbot-policie" {
#  name        = "chatbot-policy"
#  path        = "/"
#  description = "Custom policy to allow lambda inside a vpc"
#
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        "Effect": "Allow",
#        "Action": [
#          "lambda:CreateFunction",
#        ],
#        "Resource": "*"
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "s3:*Object",
#          "s3:ListBucket",
#          "s3:PutObjectAcl",
#          "s3:GetObjectAcl"
#        ],
#        "Resource": [
#          aws_s3_bucket.bhsf-web-portal-canaries.arn,
#          "${aws_s3_bucket.bhsf-web-portal-canaries.arn}/*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "logs:CreateLogStream",
#          "logs:PutLogEvents",
#          "logs:CreateLogGroup"
#        ],
#        "Resource": [
#          "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "s3:ListAllMyBuckets",
#          "xray:PutTraceSegments"
#        ],
#        "Resource": [
#          "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Resource": "*",
#        "Action": "cloudwatch:PutMetricData",
#        "Condition": {
#          "StringEquals": {
#            "cloudwatch:namespace": "CloudWatchSynthetics"
#          }
#        }
#      }
#    ]
#  })
#}
#
#resource aws_iam_role chatbot-web-role {
#  name = "chatbot-web-role-${var.env}"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [{
#      Action = "sts:AssumeRole"
#      Effect = "Allow"
#      Sid    = ""
#      Principal = {
#        Service = "management.chatbot.amazonaws.com"
#      }
#    }
#    ]
#  })
#
#  managed_policy_arns = [
#    aws_iam_policy.bot-policy.arn
#  ]
#}
#resource "aws_iam_policy" "bot-policy" {
#  name        = "bot-policy"
#  path        = "/"
#  description = "Custom policy to allow lambda inside a vpc"
#
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        "Effect": "Allow",
#        "Action": [
#          "sns:*"
#          #"sns:ListSubscriptionsByTopic",
#          #"sns:ListTopics",
#          #"sns:Unsubscribe",
#          #"sns:Subscribe",
#          #"sns:ListSubscriptions"
#        ],
#        "Resource": "*"
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "logs:PutLogEvents",
#          "logs:CreateLogStream",
#          "logs:DescribeLogStreams",
#          "logs:CreateLogGroup",
#          "logs:DescribeLogGroups"
#        ],
#        "Resource": [
#         "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "logs:CreateLogStream",
#          "logs:PutLogEvents",
#          "logs:CreateLogGroup"
#        ],
#        "Resource": [
#          "*"
#        ]
#      }
#    ]
#  })
#}
#
#
### This resource was created manually and its only in dev accourt
##--------------------------
## CANARY
##---------------------------
##resource "aws_synthetics_canary" "monitor" {
##  name                 = "baptist-web-canary-test"
##  artifact_s3_location = "s3://${aws_s3_bucket.bhsf-web-portal-canaries.bucket}/"
##  execution_role_arn   = aws_iam_role.baptisthealth-canary.arn
##  handler              = "pageLoadBlueprint.handler"
##  zip_file             = "${path.module}/lambda/lambda.zip"
##  runtime_version      = "syn-nodejs-puppeteer-3.6"
##  delete_lambda        = true
##  start_canary         = true
##  run_config {
##    timeout_in_seconds = 300
##    memory_in_mb = 960
##    active_tracing = false
##    environment_variables = {}
##  }
##
##  schedule {
##    expression = "rate(5 minutes)"
##    duration_in_seconds = 0
##  }
##}
#
#
#
#
#