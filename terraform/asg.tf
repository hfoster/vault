#AutoScaling Groups
resource "aws_launch_configuration" "app_conf" {
  ebs_optimized   = false
  name_prefix     = "vault-${var.env_name}-"
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "${var.app_instance_type}"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${data.terraform_remote_state.infrastructure.web_security_group_id}", "${data.terraform_remote_state.infrastructure.ssh_security_group_id}"]
  user_data       = "${data.template_file.app_userdata.rendered}"

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "${aws_launch_configuration.app_conf.name}-asg"
  launch_configuration = "${aws_launch_configuration.app_conf.name}"
  min_size             = "${var.asg_min_instances}"
  max_size             = "${var.asg_max_instances}"
  vpc_zone_identifier  = ["${data.terraform_remote_state.infrastructure.private_subnet_ids}"]
  load_balancers       = ["${aws_elb.web_lb.id}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "name"
    value               = "vault-${var.env_name}"
    propagate_at_launch = true
  }
}
