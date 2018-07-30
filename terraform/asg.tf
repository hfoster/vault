#AutoScaling Groups
data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7*"]
  }
}

data "template_file" "app_userdata" {
  template = "${file("app_userdata.sh.tpl")}"

  vars {
    app_name    = "${var.app_name}"
    app_version = "${var.app_version}"
  }
}

resource "aws_launch_configuration" "app_conf" {
  ebs_optimized   = false
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "${var.app_instance_type}"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${aws_security_group.web.id}", "${aws_security_group.ssh_in.id}"]
  user_data       = "${data.template_file.app_userdata.rendered}"

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "app_group"
  launch_configuration = "${aws_launch_configuration.app_conf.name}"
  min_size             = "${var.asg_min_instances}"
  max_size             = "${var.asg_max_instances}"
  vpc_zone_identifier  = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}", "${aws_subnet.private3.id}"]
  load_balancers       = ["${aws_elb.app_lb.id}"]
}

resource "aws_launch_configuration" "web_conf" {
  ebs_optimized   = false
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "${var.web_instance_type}"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${aws_security_group.web.id}", "${aws_security_group.ssh_jump.id}"]
  user_data       = "${file("web_userdata.sh")}"

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                 = "web_group"
  launch_configuration = "${aws_launch_configuration.web_conf.name}"
  min_size             = "${var.asg_min_instances}"
  max_size             = "${var.asg_max_instances}"
  vpc_zone_identifier  = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}", "${aws_subnet.public3.id}"]
  load_balancers       = ["${aws_elb.web_lb.id}"]
}

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
