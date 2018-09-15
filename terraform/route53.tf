#Route53 domain and DNS configuration
resource "aws_route53_record" "vault-external" {
  zone_id = "${var.route53_zone_id}"
  name    = "vault.${var.env_name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.web_lb.dns_name}"
    zone_id                = "${aws_elb.web_lb.zone_id}"
    evaluate_target_health = true
  }
}
