variable account {}
variable name_prefix {
    type = string
}
variable standard_tags {
    type = map(string)
}
variable ecs_cluster {
    type = string
}
variable cloudwatch_logs_retention_in_days {
    type    = number
    default = 3
}

variable turn_on_schedule {
    description = "Turn ON Schedule"
    default     = {
        name            = "${var.name_prefix}-Switch-ON"
        description     = "Turns ON cluster: ${var.name_prefix}"
        expression      = "cron(0 8 ? * SUN-FRI *)"
    }
}

variable turn_off_schedule {
    description = "Turn OFF Schedule"
    default     = {
        name            = "${var.name_prefix}-Switch-OFF"
        description     = "Turns OFF cluster: ${var.name_prefix}"
        expression      = "cron(0 22 ? * SUN-FRI *)"
    }
}
