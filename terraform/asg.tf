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
  security_groups = ["${module.infrastructure.web_security_group_id}", "${module.infrastructure.ssh_in_security_group_id}"]
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
  vpc_zone_identifier  = ["${module.infrastructure.private_subnet1_id}", "${module.infrastructure.private_subnet2_id}", "${module.infrastructure.private_subnet3_id}"]
  load_balancers       = ["${aws_elb.app_lb.id}"]
}

resource "aws_launch_configuration" "web_conf" {
  ebs_optimized   = false
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "${var.web_instance_type}"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${module.infrastructure.web_security_group_id}", "${module.infrastructure.ssh_jump_security_group_id}"]
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
  vpc_zone_identifier  = ["${module.infrastructure.public_subnet1_id}", "${module.infrastructure.public_subnet2_id}", "${module.infrastructure.public_subnet3_id}"]
  load_balancers       = ["${aws_elb.web_lb.id}"]
}
