output "website_endpoint" {
  description = "The DNS name to point CNAME records to."
  value       = "${aws_s3_bucket.default.website_endpoint}"
}
