#Route53 domain and DNS configuration
resource "aws_route53_record" "vault-external" {
  zone_id = "${data.aws_route53_zone.base_domain.zone_id}"
  name    = "${var.env_name != "prod" ? "vault.${var.env_name}.${data.aws_route53_zone.base_domain.name}" : "vault.${data.aws_route53_zone.base_domain.name}"}"
  type    = "A"

  alias {
    name                   = "${aws_elb.web_lb.dns_name}"
    zone_id                = "${aws_elb.web_lb.zone_id}"
    evaluate_target_health = true
  }
}
