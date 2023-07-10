resource "aws_s3_bucket" s3-log-bucket {
  bucket = "codepipeline-log-${var.app-name}-${var.region}-${var.environment}"
  #tags = {
  #  Environment = var.environment
  #}
}