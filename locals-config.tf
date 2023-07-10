#--------------------------
# General Settings
#---------------------------
locals {
  AWS_ACCOUNT_ID = module.ENV.AWS_ACCOUNT_ID
  app-name       = "la-taqueria"
  project-suffix = "lmk"

}

locals {
  projects = [
    {
      name = "la-taqueria",


    },
    {
      name = "cocina-del-corazon",
    }

  ]


}