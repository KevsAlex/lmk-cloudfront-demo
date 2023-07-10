#--------------------------
# CLOUDFRONT
#---------------------------

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-${aws_s3_bucket.web-bucket.bucket_regional_domain_name}"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity-failover" {
  comment = "access-identity-${aws_s3_bucket.web-portal-failover.bucket_regional_domain_name}"
}

//Defaut cache policy managed by amazon
data "aws_cloudfront_cache_policy" caching-optimized {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name    = "${var.project-suffix}-${var.app-name}-headers-policy"
  comment = "Adds HSTS headers"
  security_headers_config {

    strict_transport_security {
      access_control_max_age_sec = "5"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }

    #content_security_policy {
    #  content_security_policy = "frame-ancestors ${local.iframe-ancestor}"
    #  override = true
    #}
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.web-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.web-bucket.bucket

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  #origin {
  #  domain_name = aws_s3_bucket.web-portal-failover.bucket_regional_domain_name
  #  origin_id   = "fail-over"
#
  #  s3_origin_config {
  #    origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity-failover.cloudfront_access_identity_path
  #  }
  #}

/*
  origin {
    domain_name = "pmc-baptist-preview.provider-match.com"
    origin_id   = "kyrus"
    custom_origin_config {
      https_port = 443
      http_port = 80
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
*/

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.app-name}-${var.environment}"
  default_root_object = "index.html"

  #aliases = ["${local.cert-subdomain-name}.baptisthealth.net"]
  aliases = [var.domain]

  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    target_origin_id           = aws_s3_bucket.web-bucket.bucket
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  #ordered_cache_behavior {
  #  allowed_methods = [
  #    "GET",
  #    "HEAD",
  #  ]
  #  cache_policy_id = data.aws_cloudfront_cache_policy.caching-optimized.id#"4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  #  cached_methods  = [
  #    "GET",
  #    "HEAD",
  #  ]
  #  compress               = true
  #  default_ttl            = 0
  #  max_ttl                = 0
  #  min_ttl                = 0
  #  path_pattern           = "/400X/*"
  #  smooth_streaming       = false
  #  target_origin_id       = "fail-over"
  #  trusted_key_groups     = []
  #  trusted_signers        = []
  #  viewer_protocol_policy = "allow-all"
  #}

/*
  ordered_cache_behavior {
    allowed_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]

    forwarded_values {
      query_string = true
      headers = ["*"]
      cookies {
        forward = "none"
      }
    }
    
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    path_pattern           = "/book/*"
    smooth_streaming       = false
    target_origin_id       = "kyrus"
    trusted_key_groups     = []
    trusted_signers        = []
    viewer_protocol_policy = "allow-all"


    	lambda_function_association {
      event_type = "origin-request"
      lambda_arn = "${aws_lambda_function.lambda-kyrus-edge.qualified_arn}"
    }
  }
*/

  /*
  origin_group {
    origin_id = "TestGroup"
    failover_criteria {
      status_codes = [
        403,
      ]
    }
    member {
      origin_id = "bhsf-web-portal"
    }
    member {
      origin_id = "fail-over"
    }
  }*/

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  #web_acl_id = aws_wafv2_web_acl.waf.arn

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_page_path    = "/index.html"
    response_code         = 200
  }

  viewer_certificate {
    #cloudfront_default_certificate = true
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.certificate-arn
    #acm_certificate_arn            = var.certificate-arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1"
  }
}