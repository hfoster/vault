#AutoScaling Groups
data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["centos-*-plain-x86_64-*"]
  }
}

resource "aws_launch_configuration" "app_conf" {
  name          = "app-config"
  image_id      = "${data.aws_ami.centos7.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ec2_key_pair}"

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
}

resource "aws_launch_configuration" "web_conf" {
  name          = "web-config"
  image_id      = "${data.aws_ami.centos7.id}"
  instance_type = "t2.nano"
  key_name      = "${var.ec2_key_pair}"

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
}
