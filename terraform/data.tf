#Entrypoint for the stack
provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

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

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config {
    bucket = "${var.infra_bucket_name}"
    key    = "modules/high-availability/${var.env_name}.tfstate"
    region = "${var.aws_region}"
  }
}

data "aws_route53_zone" "base_domain" {
  name = "${var.base_domain_name}"
}
