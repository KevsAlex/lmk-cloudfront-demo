output AWS_ACCOUNT_ID {
  value = local.AWS_ACCOUNT_ID[var.environment]
}

output codestar-id {
  value = local.codestar-id[var.environment]
}

output region {
  value = local.region[var.environment]
}



output certificate-arn {
  value = local.certificate-arn[var.environment]
}

output domain-template {
  value = local.domain-template[var.environment]
}

output domain-cachutacos {
  value = local.domain-cachutacos[var.environment]
}








