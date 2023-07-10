locals {
  repo-branch-name = {
    staging = "staging-nride"
    prod  = "master"
  }
}

#--------------------------
# Backend pipelines
#---------------------------
resource "aws_codepipeline" pipeline {
  #for_each = aws_iam_role.pipeline-roles

  name     = local.this
  role_arn = aws_iam_role.pipeline-roles.arn
  #role_arn = "arn:aws:iam::${var.AWS_ACCOUNT_ID}:role/service-role/AWSCodePipelineServiceRole-${var.region}-${each.key}"//each.value.arn

  artifact_store {
    #location = "codepipeline-${var.AWS_DEFAULT_REGION}-518971726053"
    location = aws_s3_bucket.s3-log-bucket.bucket#"codepipeline-log-${var.app-name}-${var.region}-${var.environment}"#aws_s3_bucket.s3-log-bucket.bucket
    type     = "S3"
  }

  stage {
    name = local.SOURCE

    action {

      name          = local.SOURCE
      configuration = {
        ConnectionArn    = var.codestar-id#"arn:aws:codestar-connections:${var.region}:${var.AWS_ACCOUNT_ID}:connection/${var.codestar-id}"
        #FullRepositoryId = "${var.GIT_HUB_ACCOUNT}/${each.key}"
        #FullRepositoryId = "https://github.com/${var.git-account-name}/${each.value["git-name"]}"
        FullRepositoryId = "${var.git-account-name}/${var.repo-name}"
        OutputArtifactFormat = "CODE_ZIP"
        BranchName       = local.repo-branch-name[var.environment]
      }
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

    }
  }

  stage {
    name = local.BUILD

    action {
      name = local.BUILD
      namespace = "BuildVariables"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = [
        "source_output"]
      output_artifacts = [
        "BuildArtifact"]
      version = "1"

      configuration = {
        ProjectName = local.this

      }
    }
  }

  #stage {
  #  name = "Approval"
  #
  #  action {
  #    category  = "Approval"
  #    name      = "ManualApproval"
  #    owner     = "AWS"
  #    provider  = "Manual"
  #    region    = var.AWS_DEFAULT_REGION
  #    run_order = 1
  #    version   = "1"
  #
  #    input_artifacts  = []
  #    output_artifacts = []
  #
  #
  #    configuration = {
  #      NotificationArn = "arn:aws:sns:us-east-1:798152040102:repository-notifications-manual"
  #    }
  #  }
  #}



  depends_on = [aws_iam_role.pipeline-roles]

}

resource "aws_iam_role" pipeline-roles {

  name = "AWSCodePipelineServiceRole-${var.region}-${local.this}"
  path = "/service-role/"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    aws_iam_policy.pipeline-policy.arn

  ]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
  tags = {

  }
}











