provider "aws" {
  region = "${var.region}"
  alias  = "this"
}

resource "aws_s3_bucket" "default" {
  provider = "aws.this"
  bucket   = "${var.bucket}"
  acl      = "public-read"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
  }

  website {
    index_document = "index.html"
    error_document = "${var.error_document}"
  }
}

resource "aws_s3_bucket_policy" "default" {
  provider = "aws.this"
  bucket   = "${aws_s3_bucket.default.id}"
  policy   = "${data.aws_iam_policy_document.default.json}"
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.default.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "logs" {
  provider = "aws.this"
  bucket   = "${var.bucket}-logs"
  acl      = "log-delivery-write"
}

data "aws_route53_zone" "z" {
  provider = "aws.this"
  count    = "${var.route53_zone != "0" ? 1 : 0}"
  name     = "${var.route53_zone}"
}

resource "aws_route53_record" "r" {
  provider = "aws.this"
  count    = "${var.route53_zone != "0" ? 1 : 0}"
  zone_id  = "${data.aws_route53_zone.z.zone_id}"
  name     = "${aws_s3_bucket.default.id}"
  type     = "A"

  alias {
    name                   = "${aws_s3_bucket.default.website_domain}"
    zone_id                = "${aws_s3_bucket.default.hosted_zone_id}"
    evaluate_target_health = false
  }
}
