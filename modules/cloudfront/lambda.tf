/*
data "archive_file" "zip_kyrus_origin_lambda" {
    type        = "zip"
    source_dir  = "${path.module}/lambda/kyrus-origin-request/"
    output_path = "${path.module}/lambda/kyrus-origin-request-lambda.zip"
}
*/
#provider "aws" {
#  alias  = "us_east_1"
#  region = "us-east-1"
#}

/*
resource "aws_lambda_function" "lambda-kyrus-edge" {
  filename      = "${path.module}/lambda/lambda.zip"
  function_name = "lambda-pineapp-web-kyrus-lambda-edge-${local.environment}"
  role          = aws_iam_role.lambda_at_edge.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  publish       = true
  #provider      = aws.us_east_1
  depends_on    = [aws_iam_role.lambda_at_edge]



}
variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}
*/

#resource "aws_s3_bucket_object" "lambda_function_v2" {
#
#  bucket     = aws_s3_bucket.bhsf-web-portal-canaries.id
#  key        = "canary/lambda.zip"
#  acl           = "private"
#  server_side_encryption = "aws:kms"
#  source     = data.archive_file.source.output_path
#  depends_on = [aws_s3_bucket.bhsf-web-portal-canaries]
#
#  //source = "index.js"
#}

#resource "aws_s3_bucket_object" "lambda_function_hash-v2" {
#
#  bucket     = aws_s3_bucket.bhsf-web-portal-canaries.id
#  key        = "canary/lambda.zip.base64sha256"
#  acl           = "private"
#  server_side_encryption = "aws:kms"
#  depends_on = [aws_s3_bucket.bhsf-web-portal-canaries]
#  //source = "index.js"
#  source     = data.archive_file.source.output_path
#}

#data archive_file source {
#  type        = "zip"
#  source_file  = "${path.module}/lambda/index.js"
#  output_path = "${path.module}/lambda/lambda.zip"
#}