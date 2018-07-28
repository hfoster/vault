#AutoScaling Groups
data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["centos-*-plain-x86_64-*"]
  }
}

resource "aws_launch_configuration" "app_conf" {
  name            = "app-config"
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${aws_security_group.web.id}", "${aws_security_group.ssh_in.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "app_group"
  launch_configuration = "${aws_launch_configuration.app_conf.name}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}", "${aws_subnet.private3.id}"]
  load_balancers       = ["${aws_elb.app_lb.id}"]
}

resource "aws_launch_configuration" "web_conf" {
  name            = "web-config"
  image_id        = "${data.aws_ami.centos7.id}"
  instance_type   = "t2.nano"
  key_name        = "${var.ec2_key_pair}"
  security_groups = ["${aws_security_group.web.id}", "${aws_security_group.ssh_jump.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                 = "web_group"
  launch_configuration = "${aws_launch_configuration.web_conf.name}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}", "${aws_subnet.public3.id}"]
  load_balancers       = ["${aws_elb.web_lb.id}"]
}
