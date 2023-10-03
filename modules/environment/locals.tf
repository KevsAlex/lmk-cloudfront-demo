locals {
  #--------------------------
  # GENERAL ACCOUNT
  #---------------------------
  environments = {
    staging = "staging"
    prod    = "prod"
  }

  AWS_ACCOUNT_ID = {
    description = "AWS ACCOUNT"

    staging = ""
    prod    = "084165404291"

  }

  codestar-id = {
    description = "CODE STAR arn id , used for setting up code pipeline"
    staging     = ""
    prod        = "arn:aws:codestar-connections:us-east-2:084165404291:connection/4c19e4b8-ad2c-4bc2-9847-09649cf95447"

  }

  region = {
    description = "us-east-1"
    staging     = "us-east-1"
    prod        = "us-west-2"
  }
  //Cloudfront certificate domain (manually created)
  certificate-arn = {
    description = "us-east-1"
    staging     = ""
    prod        = "arn:aws:acm:us-east-1:084165404291:certificate/7a04d9da-d8a8-4263-b61d-efc4a8790288"
  }

  domain-template = {
    description = "us-east-1"
    staging     = ""
    prod        = "lataqueria.lmeknow.com"
  }

  domain-cachutacos = {
    description = "us-east-1"
    staging     = "cachutacos.lmeknow.com"
    prod        = "cachutacos.lmeknow.com"
  }


}