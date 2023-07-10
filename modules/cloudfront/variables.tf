#--------------------------
# PROJECT VARIABLES
#---------------------------

variable environment {
  description = "Environment selected, this is set to development,stage,prod for aws account"
  type        = string
}

variable region {

}

variable project-suffix {
  description = "project suffix"
  type        = string
}

variable app-name {
  description = "Environment selected, this is set to development,stage,prod for aws account"
  type        = string
}

variable certificate-arn {
  description = "domain certificate arn"
  type = string
}

variable domain {
  description = "domain name"
  type = string
}