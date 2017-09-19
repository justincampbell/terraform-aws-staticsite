variable "bucket" {
  description = "The name of the S3 bucket. This is recommended to be host+domain, such as www.justincampbell.me"
}

variable "domain" {
  description = "Your domain name."
}

variable "region" {
  default = "us-east-1"
}
