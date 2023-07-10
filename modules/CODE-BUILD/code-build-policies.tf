locals {
  this = "${var.app-name}-${var.environment}"

}

resource "aws_iam_role" "codebuild-role" {

  name = "codebuild-${local.this}-service-role"
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
  managed_policy_arns = [

    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    aws_iam_policy.CodeBuildBasePolicy.arn,
    aws_iam_policy.pipeline-policy.arn
  ]
  path = "/service-role/"

  tags = {

  }
}

resource "aws_iam_policy" "CodeBuildBasePolicy" {

  tags        = {}
  tags_all    = {}
  name        = "CodeBuildBasePolicy-${local.this}-${var.region}"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:logs:${var.region}:${var.AWS_ACCOUNT_ID}:log-group:/aws/codebuild/${local.this}",
          "arn:aws:logs:${var.region}:${var.AWS_ACCOUNT_ID}:log-group:/aws/codebuild/${local.this}:*",
          "arn:aws:logs:*:${var.AWS_ACCOUNT_ID}:log-group:*:log-stream:*"
          //"${aws_s3_bucket.omnia-s3-log-bucket.arn}"
        ]
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = [
          //"arn:aws:s3:::codepipeline-${var.AWS_DEFAULT_REGION}-*",
          aws_s3_bucket.s3-log-bucket.arn,
          "${aws_s3_bucket.s3-log-bucket.arn}/*"

        ]
      },
      {
        Action = [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases",
          "codebuild:BatchPutCodeCoverages",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:logs:*:${var.AWS_ACCOUNT_ID}:log-group:*",
          "arn:aws:codebuild:${var.region}:${var.AWS_ACCOUNT_ID}:report-group/${local.this}-*"
        ]
      },
      {
        Action = [
          "codeartifact:ReadFromRepository",
          "codeartifact:GetAuthorizationToken",
          "sts:GetServiceBearerToken"
        ]
        Effect   = "Allow"
        Resource = [
          "*"
        ]
      },
      {
        Action = [
          "cloudfront:CreateInvalidation"
        ]
        Effect   = "Allow"
        Resource = [
          "*"
        ]
      }
    ]
  })

  #depends_on = [aws_s3_bucket.s3-log-bucket]
}

resource "aws_iam_policy" "pipeline-policy" {

  tags        = {}
  tags_all    = {}
  name        = "AWSCodePipelineServiceRole-${var.region}-${local.this}"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodePipeline"

  policy = file("${path.module}/pipeline-policie.json")
}