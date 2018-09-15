#Elastic Load Balencers
resource "aws_elb" "web_lb" {
  name                      = "web-load-balancer"
  cross_zone_load_balancing = true
  subnets                   = ["${data.terraform_remote_state.infrastructure.public_subnet_ids}"]
  security_groups           = ["${data.terraform_remote_state.infrastructure.elb_security_group_id}"]
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
    Name = "${var.env_name}-web-elb"
  }
}
