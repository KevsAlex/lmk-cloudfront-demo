#--------------------------
# Domain configuration
#---------------------------

locals {

  domain = var.environment == "staging" ? "stg.admin.neoride.com" : var.environment == "prod" ? "lataqueria.lmeknow.com" : ""
}

#resource "aws_acm_certificate" "cert-new" {
#  domain_name       = local.domain
#  validation_method = "DNS"
#
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}