#--------------------------
# WEB SITE POLICIES
#---------------------------

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.web-bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

data "aws_iam_policy_document" "s3_policy-failover" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.web-portal-failover.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity-failover.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.web-bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_policy" policy-failover {
  bucket = aws_s3_bucket.web-portal-failover.id
  policy = data.aws_iam_policy_document.s3_policy-failover.json
}

/*
  ~ resource "aws_s3_bucket_policy" "mybucket" {
        id     = "s3-bhsf-web-portal-dev"
      ~ policy = jsonencode(
            {
              - Statement = [
                  - {
                      - Action    = "s3:GetObject"
                      - Effect    = "Allow"
                      - Principal = {
                          - AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ED1HRFR5N8TVG"
                        }
                      - Resource  = "arn:aws:s3:::s3-bhsf-web-portal-dev/*"
                      - Sid       = ""
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> (known after apply)
        # (1 unchanged attribute hidden)
    }
*/

/**
 * Make a role that AWS services can assume that gives them access to invoke our function.
 * This policy also has permissions to write logs to CloudWatch.
 */
#resource "aws_iam_role" "lambda_at_edge" {
#  name               = "pineweb-lambda-edge-${var.environment}"
#  assume_role_policy = jsonencode({
#    Version   = "2012-10-17"
#    Statement = [
#      {
#        Sid       = ""
#        Effect    = "Allow"
#        Action    = "sts:AssumeRole"
#        Principal = {
#          Service = [
#            "edgelambda.amazonaws.com",
#            "lambda.amazonaws.com"
#          ]
#        }
#      }
#    ]
#  })
#  managed_policy_arns = [
#    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
#  ]
#
#}