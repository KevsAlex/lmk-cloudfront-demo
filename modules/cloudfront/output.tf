#--------------------------
# CUSTOM OUTPUT
#---------------------------

output "inline" {
  value = <<EOT

----------------------------------
BHSF Web Portal
----------------------------------

environment : ${var.environment}
DOMAIN NAME : ${aws_cloudfront_distribution.s3_distribution.domain_name}

EOT
}

output cloudfront-id {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output cloudfront-bucket{
  value = aws_s3_bucket.web-bucket.bucket
}