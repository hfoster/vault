variable "aws_region" {
  description = "The AWS region to create things in"
  default     = "eu-west-2"
}

variable "vpc_cidr_block" {
  description = "The base CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "ec2_key_pair" {
  description = "The AWS Key Pair for accessing hosts"
  default     = "eu-west-2-test.key"
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

variable "asg_desired_capacity" {
  default = "1"
}
