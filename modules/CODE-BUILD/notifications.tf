
#resource "aws_sns_topic" pipeline-notifications {
#
#  name   = "pipeline-notifications"
#  policy = <<EOF
#{
#  "Version": "2008-10-17",
#  "Statement": [
#    {
#      "Sid": "CodeNotification_publish",
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "codestar-notifications.amazonaws.com"
#      },
#      "Action": "SNS:Publish",
#      "Resource": "*"
#    }
#  ]}
#
#EOF
#}

#resource "aws_codestarnotifications_notification_rule" "pipeline-execution" {
#  //for_each       = aws_codepipeline.pipeline
#  name           = "pipeline-alarm-${var.app-name}-config-${var.environment}"
#  detail_type    = "BASIC"
#  event_type_ids = [
#    "codepipeline-pipeline-manual-approval-needed",
#    "codepipeline-pipeline-pipeline-execution-failed",
#    "codepipeline-pipeline-pipeline-execution-succeeded"
#  ]
#
#  resource = aws_codepipeline.pipeline.arn//"arn:aws:iam::694318308046:role/service-role/AWSCodePipelineServiceRole-us-east-1-nride-configfiles-staging"//each.value.arn
#
#  target {
#    address = aws_sns_topic.pipeline-notifications.arn
#    type    = "SNS"
#  }
#  #target {
#  #  address = local.chat-bot-address
#  #  type    = "AWSChatbotSlack"
#  #}
#}
#
#resource "aws_sns_topic_subscription" "bhmobile_alerts_topic_subscription-reformat" {
#
#  topic_arn = aws_sns_topic.pipeline-notifications.arn
#  protocol  = "lambda"
#  endpoint  = aws_lambda_function.notification-event.arn
#}