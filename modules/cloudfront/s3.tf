#--------------------------
# WEB S3 Bucket
#---------------------------
resource "aws_s3_bucket" web-bucket {
  bucket = "${var.project-suffix}-${var.app-name}-${var.environment}"
}

resource "aws_s3_bucket_public_access_block" "web-bucket-access" {
  bucket = aws_s3_bucket.web-bucket.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.web-bucket.bucket

  index_document {
    suffix = "index.html"
  }
  #CHANGED THIS
  #error_document {
  #  key = "error.html"
  #}

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_acl" bucket_acl {
  bucket = aws_s3_bucket.web-bucket.id
  acl    = "private"
}

#--------------------------
# WEB S3 FAILOVER
#---------------------------
resource "aws_s3_bucket" web-portal-failover {
  bucket = "${var.app-name}-failover-${var.environment}"
}

resource "aws_s3_bucket_public_access_block" "bhsf-mobile-failover-config-access" {
  bucket = aws_s3_bucket.web-portal-failover.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

resource "aws_s3_bucket_acl" bucket_acl_failover {
  bucket = aws_s3_bucket.web-portal-failover.id
  acl    = "private"
}

#resource aws_s3_object "web_files" {
#  for_each = module.template_files.files
#
#  bucket       = aws_s3_bucket.web-portal-failover.id
#  key          = each.key
#  content_type = each.value["content_type"]
#
#  source  = each.value["source_path"]
#  content = each.value["content"]
#
#  etag = each.value["digests"]["md5"]
#}

#module "template_files" {
#  //source = "git@gitlab.com:bhsf/architecture/terraform-modules/aws/terraform-template-dir.git?ref=v1.0.2"
#  source = "https://github.com/hashicorp/terraform-template-dir.git"
#
#  base_dir = "web_files"
#}