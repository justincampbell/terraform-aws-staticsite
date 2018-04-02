variable "bucket" {
  description = "The name of the S3 bucket. This is recommended to be host+domain, such as www.justincampbell.me"
}

variable "domain" {
  description = "Your domain name."
}

variable "error_document" {
  description = "Path for a page to return on 404 and other errors."
  default     = "error.html"
}

variable "region" {
  description = "The AWS region."
  default     = "us-east-1"
}

variable "index_document" {
  description = "Use a different index document"
  default     = "index.html"
}
