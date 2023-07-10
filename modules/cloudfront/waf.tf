#--------------------------
# WAF CONFIG
#---------------------------

#resource aws_wafv2_web_acl waf {
#  name        = "${var.app-name}-web-portal"
#  description = "Cloudfront rate based statement."
#  scope       = "CLOUDFRONT"
#
#  default_action {
#    allow {}
#  }
#
#  rule {
#    name     = "rule-1"
#    priority = 1
#
#    action {
#      block {}
#    }
#
#    statement {
#      rate_based_statement {
#        limit              = 10000
#        aggregate_key_type = "IP"
#
#        scope_down_statement {
#          geo_match_statement {
#            country_codes = ["US", "NL"]
#          }
#        }
#      }
#    }
#
#    visibility_config {
#      cloudwatch_metrics_enabled = false
#      metric_name                = "rate_limit"
#      sampled_requests_enabled   = false
#    }
#  }
#
#  visibility_config {
#    cloudwatch_metrics_enabled = false
#    metric_name                = "rate_limit"
#    sampled_requests_enabled   = false
#  }
#
#  tags        = {}
#}