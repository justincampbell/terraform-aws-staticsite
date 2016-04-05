provider "aws" {
  region = "${var.region}"
}

resource "dnsimple_record" "default" {
  domain = "${var.domain}"
  name   = "${var.host}"
  type   = "CNAME"
  value  = "${aws_s3_bucket.default.website_endpoint}"
}

resource "aws_s3_bucket" "default" {
  bucket = "${var.bucket}"
  acl    = "public-read"
  policy = "${template_file.policy.rendered}"

  website {
    index_document = "index.html"
  }
}

resource "template_file" "policy" {
  template = "${file("${path.module}/policy.json")}"

  vars {
    bucket = "${var.bucket}"
  }
}
