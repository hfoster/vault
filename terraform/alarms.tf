#CloudWatch alarms
resource "aws_cloudwatch_metric_alarm" "web_scaling_alarm" {
  alarm_name          = "WebServerScalingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_description   = "Alarm governing scaling of the webserver group according to ELB RequestCount"
  evaluation_periods  = 2
  metric_name         = "RequestCount"
  namespace           = "AWS/ELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 150

  dimensions {
    LoadBalancerName = "${aws_elb.web_lb.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.web_scale_up.arn}"]
  ok_actions    = ["${aws_autoscaling_policy.web_scale_down.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "app_scaling_alarm" {
  alarm_name          = "AppServerScalingAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_description   = "Alarm governing scaling of the app server group according to ELB RequestCount"
  evaluation_periods  = 2
  metric_name         = "RequestCount"
  namespace           = "AWS/ELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 150

  dimensions {
    LoadBalancerName = "${aws_elb.app_lb.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.app_scale_up.arn}"]
  ok_actions    = ["${aws_autoscaling_policy.app_scale_down.arn}"]
}
