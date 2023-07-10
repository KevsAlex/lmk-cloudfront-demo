#--------------------------
# CodeBuild
#---------------------------
locals {
  repo-branch = {
    staging = "refs/heads/"
    prod  = "refs/heads/master"
  }
}

resource "aws_codebuild_project" "code-compilations" {
  //Needed iterate through role for getting codebuild role
  #for_each = aws_iam_role.codebuild-roles
  name = local.this
  service_role = aws_iam_role.codebuild-role.arn
  source_version = local.repo-branch[var.environment]//"refs/heads/staging"
  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    modes = []
    type = "NO_CACHE"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    privileged_mode = true
    image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type = "LINUX_CONTAINER"

    environment_variable {
      name  = "BUCKET_NAME"
      type  = "PLAINTEXT"
      value = var.cloudfront-bucket
    }

    environment_variable {
      name  = "ENVIRONMENT"
      type  = "PLAINTEXT"
      value = var.environment
    }

    environment_variable {
      name  = "CLOUDFRONT_ID"
      type  = "PLAINTEXT"
      value = var.cloudfront-id
    }

  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status = "DISABLED"
    }
  }


  source {
    buildspec = local.BUIL_SPECT
    git_clone_depth = 1
    insecure_ssl = false
    #location = "https://github.com/${var.git-account-name}/${each.key}.git"
    location = "https://github.com/${var.git-account-name}/${var.repo-name}.git"

    report_build_status = false
    type = "GITHUB"

    git_submodules_config {
      fetch_submodules = false
    }
  }



  tags ={}

  depends_on = [aws_iam_role.codebuild-role]
}
