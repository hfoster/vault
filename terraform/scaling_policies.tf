#Scaling policies
resource "aws_autoscaling_policy" "web_scale_up" {
  name                   = "web_scale_up_policy"
  autoscaling_group_name = "${aws_autoscaling_group.web_asg.name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

resource "aws_autoscaling_policy" "web_scale_down" {
  name                   = "web_scale_down_policy"
  autoscaling_group_name = "${aws_autoscaling_group.web_asg.name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 600
}

resource "aws_autoscaling_policy" "app_scale_up" {
  name                   = "app_scale_up_policy"
  autoscaling_group_name = "${aws_autoscaling_group.app_asg.name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

resource "aws_autoscaling_policy" "app_scale_down" {
  name                   = "app_scale_down_policy"
  autoscaling_group_name = "${aws_autoscaling_group.app_asg.name}"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 600
}
