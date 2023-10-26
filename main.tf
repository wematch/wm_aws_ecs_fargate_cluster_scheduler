data aws_region current {}

# ---------------------------------------------------
#    Lambda ON
# ---------------------------------------------------
module cluster_on {
    source  = "terraform-aws-modules/lambda/aws"
    version = "~> 6.0"

    function_name                       = "${var.name_prefix}-Switch-Cluster-ON"
    description                         = "Switch cluster ON: ${var.name_prefix}"
    handler                             = "lambda_on.lambda_handler"
    runtime                             = "python3.9"
    timeout                             = 60
    memory_size                         = 512
    maximum_retry_attempts              = 3
    attach_policy                       = true
    create_package                      = false
    local_existing_package              = "${path.module}/lambda_on.zip"
    policy                              = aws_iam_policy.policy.arn
    tags                                = var.standard_tags
    cloudwatch_logs_retention_in_days   = var.cloudwatch_logs_retention_in_days

    environment_variables = {
        ECS_CLUSTER = var.ecs_cluster
    }
}

resource aws_cloudwatch_event_rule cluster_on {
    name                = "${var.name_prefix}-turn-on"
    description         = "Turns ON cluster: ${var.name_prefix}"
    schedule_expression = var.turn_on_schedule
}

resource aws_cloudwatch_event_target cluster_on {
    rule    = aws_cloudwatch_event_rule.cluster_on.name
    arn     = module.cluster_on.lambda_function_arn
}

resource aws_lambda_permission cluster_on {
    statement_id    = "AllowExecutionFromCloudWatch"
    action          = "lambda:InvokeFunction"
    function_name   = module.cluster_on.lambda_function_name
    principal       = "events.amazonaws.com"
    source_arn      = aws_cloudwatch_event_rule.cluster_on.arn
}

# ---------------------------------------------------
#    Lambda OFF
# ---------------------------------------------------
module cluster_off {
    source  = "terraform-aws-modules/lambda/aws"
    version = "~> 6.0"

    function_name                       = "${var.name_prefix}-Switch-Cluster-OFF"
    description                         = "Switch cluster OFF: ${var.name_prefix}"
    handler                             = "lambda_off.lambda_handler"
    runtime                             = "python3.9"
    timeout                             = 60
    memory_size                         = 512
    maximum_retry_attempts              = 3
    attach_policy                       = true
    create_package                      = false
    local_existing_package              = "${path.module}/lambda_off.zip"
    policy                              = aws_iam_policy.policy.arn
    tags                                = var.standard_tags
    cloudwatch_logs_retention_in_days   = var.cloudwatch_logs_retention_in_days

    environment_variables = {
        ECS_CLUSTER = var.ecs_cluster
    }
}

resource aws_cloudwatch_event_rule cluster_off {
    name                = "${var.name_prefix}-turn-off"
    description         = "Turns OFF cluster: ${var.name_prefix}"
    schedule_expression = var.turn_off_schedule
}

resource aws_cloudwatch_event_target cluster_off {
    rule    = aws_cloudwatch_event_rule.cluster_off.name
    arn     = module.cluster_off.lambda_function_arn
}

resource aws_lambda_permission cluster_off {
    statement_id    = "AllowExecutionFromCloudWatch"
    action          = "lambda:InvokeFunction"
    function_name   = module.cluster_off.lambda_function_name
    principal       = "events.amazonaws.com"
    source_arn      = aws_cloudwatch_event_rule.cluster_off.arn
}

# ---------------------------------------------------
#    Shared Policy
# ---------------------------------------------------
resource aws_iam_policy policy {
    name        = "${var.name_prefix}-Cluster-Scheduler"
    path        = "/"
    description = "Turn ON / OFF cluster: ${var.ecs_cluster}"

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
            {
                Action = [
                    "ecs:ListServices",
                    "ecs:DescribeServices",
                    "ecs:UpdateService"
                ]
                Effect   = "Allow"
                Resource = "*"
                Condition = {
                    ArnEquals = {
                        "ecs:cluster" = var.ecs_cluster
                    }
                }
            }
        ]
    })
}
