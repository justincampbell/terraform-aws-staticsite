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
  policy = "${data.template_file.policy.rendered}"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.bucket}-logs"
  acl    = "log-delivery-write"
}

data "template_file" "policy" {
  template = "${file("${path.module}/policy.json")}"

  vars {
    bucket = "${var.bucket}"
  }
}
