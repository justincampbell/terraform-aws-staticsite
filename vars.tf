variable "domain" {
  description = "Your domain name."
  default     = "terraform-aws-staticsite-test.com"
}

variable "host" {
  default = "www"
}

variable "bucket" {
  description = "The name of the S3 bucket. This is recommended to be host+domain, such as www.justincampbell.me"
  default     = "terraform-aws-staticsite-test"
}

variable "region" {
  default = "us-east-1"
}
