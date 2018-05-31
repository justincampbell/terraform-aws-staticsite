output "website_endpoint" {
  description = "The DNS name to point CNAME records to."
  value       = "${aws_s3_bucket.default.website_endpoint}"
}

output "website_domain" {
  description = "The website_domain for the s3 bucket."
  value       = "${aws_s3_bucket.default.website_domain}"
}
