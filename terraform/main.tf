#Entrypoint for the stack
provider "aws" {
  region = "${var.aws_region}"
}

module "infrastructure" {
  source = "git@github.com:hfoster/common-infrastructure.git"
}
