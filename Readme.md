# lmk-terraform-cloudfrontdemo

![Next][aws] ![Next][terraform]

Demo project for building cloudfront web pages . 

![Alt text](https://ecu-infra-images.s3.us-east-2.amazonaws.com/cloudfront.drawio.png "Optional title")



## <a name="CODE_BUILD"></a> CODE BUILD
```hcl
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
```

```hcl
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
```




| Description              | Link |
|--------------------------|------|
| Cloudfront doc ecs video | https://aws.amazon.com/cloudfront/features/?nc=sn&loc=2&whats-new-cloudfront.sort-by=item.additionalFields.postDateTime&whats-new-cloudfront.sort-order=desc|
| terraform doc            | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution|

[terraform]: https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white
[aws]: https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white

[source]: https://dev.to/envoy_/150-badges-for-github-pnk
