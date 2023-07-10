#--------------------------
# Environment config
#---------------------------
module "ENV" {
  source      = "./modules/environment"
  environment = var.environment
}

#--------------------------
# LA TAQUERIA
#---------------------------
module "CLOUD_FRONT" {
  source = "./modules/cloudfront"

  app-name        = local.app-name
  environment     = var.environment
  region          = module.ENV.region
  certificate-arn = module.ENV.certificate-arn
  project-suffix  = local.project-suffix
  domain          = module.ENV.domain-template
}

#--------------------------
# CACHU TACOS
#---------------------------
module "CLOUDFRONT_CACHUTACOS" {
  source = "./modules/cloudfront"

  app-name        = "cachutacos"
  environment     = var.environment
  region          = module.ENV.region
  certificate-arn = "arn:aws:acm:us-east-1:084165404291:certificate/9e0dfea9-e246-4871-9e2b-f5054ffc3ade"
  project-suffix  = local.project-suffix
  domain          = module.ENV.domain-cachutacos
}

#--------------------------
# CODE-BUILD Repositories config
#---------------------------
module "CODE-BUILD" {
  source = "./modules/CODE-BUILD"

  AWS_ACCOUNT_ID    = module.ENV.AWS_ACCOUNT_ID
  app-name          = local.app-name
  codestar-id       = module.ENV.codestar-id
  environment       = var.environment
  git-account-name  = "KevsAlex"
  repo-name         = "lmk-menu-taqueria"
  region            = module.ENV.region
  cloudfront-bucket = module.CLOUD_FRONT.cloudfront-bucket
  cloudfront-id     = module.CLOUD_FRONT.cloudfront-id
  depends_on = [module.CLOUD_FRONT]
}

#--------------------------
# CODE-BUILD Repositories config
#---------------------------
module "CODE-BUILD-CACHUTACOS" {
  source = "./modules/CODE-BUILD"

  AWS_ACCOUNT_ID    = module.ENV.AWS_ACCOUNT_ID
  app-name          = "cachutacos"
  codestar-id       = module.ENV.codestar-id
  environment       = var.environment
  git-account-name  = "KevsAlex"
  repo-name         = "lmk-cachutacos"
  region            = module.ENV.region
  cloudfront-bucket = module.CLOUDFRONT_CACHUTACOS.cloudfront-bucket
  cloudfront-id     = module.CLOUDFRONT_CACHUTACOS.cloudfront-id
  depends_on = [module.CLOUDFRONT_CACHUTACOS]
}


