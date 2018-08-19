variable "aws_region" {
  description = "The AWS region to create things in"
  default     = "eu-west-2"
}

variable "ec2_key_pair" {
  description = "The AWS Key Pair for accessing hosts. Define at apply time with the -var flag"
}

variable "app_name" {
  description = "The app we're installing"
  default     = "vault"
}

variable "app_version" {
  description = "Our app version"
  default     = "0.10.4"
}

variable "app_instance_type" {
  default = "t2.nano"
}

variable "web_instance_type" {
  default = "t2.nano"
}

variable "asg_min_instances" {
  default = "1"
}

variable "asg_max_instances" {
  default = "3"
}

variable "route53_zone_id" {
  description = "The AWS Route53 Zone to which we are adding our DNS records. Define at apply time with the -var flag"
}

variable "domain_name" {
  description = "The domain under which we will create our subdomains. Define at apply time with the -var flag"
}

variable "env_name" {
  description = "Environment name with a trailing dot - e.g. 'dev.'. Leave blank for Production."
  default     = "dev."
}
