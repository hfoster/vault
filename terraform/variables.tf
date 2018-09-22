variable "aws_region" {
  description = "The AWS region to create things in"
  default     = "eu-west-2"
}

variable "ec2_key_pair" {
  description = "The AWS Key Pair for accessing hosts. Define at plan time with the -var flag"
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

variable "asg_min_instances" {
  default = "1"
}

variable "asg_max_instances" {
  default = "3"
}

variable "base_domain_name" {
  description = "The domain under which we will create our subdomains. Define at plan time with the -var flag"
}

variable "env_name" {
  description = "Environment name - e.g. lab/dev/prod. Define at plan time with the -var flag"
}

variable "infra_bucket_name" {
  description = "The Terraform backend S3 bucket name"
  default     = "terraform-infrastructure-modules-backend-bucket"
}
