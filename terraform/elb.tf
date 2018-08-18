#Elastic Load Balencers
resource "aws_elb" "web_lb" {
  name                      = "web-load-balancer"
  cross_zone_load_balancing = true
  subnets                   = ["${module.infrastructure.public_subnet_ids}"]
  security_groups           = ["${module.infrastructure.web_security_group_id}"]
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
  subnets                   = ["${module.infrastructure.private_subnet_ids}"]
  security_groups           = ["${module.infrastructure.web_security_group_id}"]
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
