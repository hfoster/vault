#Elastic Load Balencers
resource "aws_elb" "web_lb" {
  name                      = "web-load-balancer"
  cross_zone_load_balancing = true
  subnets                   = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}", "${aws_subnet.public3.id}"]
  security_groups           = ["${aws_security_group.web.id}"]
  internal                  = false

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags {
    Name = "web-elb"
  }
}

resource "aws_elb" "app_lb" {
  name                      = "app-load-balancer"
  cross_zone_load_balancing = true
  subnets                   = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}", "${aws_subnet.private3.id}"]
  security_groups           = ["${aws_security_group.web.id}"]
  internal                  = true

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags {
    Name = "app-elb"
  }
}
