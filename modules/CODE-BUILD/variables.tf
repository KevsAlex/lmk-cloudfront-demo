#-----------------
# LISTA DE REPOSITORIOS
#-----------------
variable services {
  type    = list(map(string))
  default = [
    {
      name = "image-1234",
      port = 8421
      git-name = "gitname"
    }
  ]
}

variable "AWS_ACCOUNT_ID" {
  description = "AWS_ACCOUNT_ID"
  type        = string
}

variable "region" {
  description = "AWS_ACCOUNT_ID"
  type        = string
}


#-----------------
# AMBIENTE (stage , prod)
#-----------------
variable "environment" {
  type = string
}

variable git-account-name {
  description = "git account name like https://github.com/<git-account-name>"
  type = string
}

variable codestar-id {
  description = "codestar id number"
  type = string
}

variable app-name{
  description = "Describe the name of your project, this variable is used for name ecs cluster"
  type        = string
}

variable cloudfront-bucket {
  type        = string
}

variable cloudfront-id {
  type        = string
}

variable repo-name{
  type        = string
}
#variable git-url{
#  description = "git-url like https://github.com"
#  type = string
#}

