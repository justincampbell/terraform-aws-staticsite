provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "default" {
  bucket = "${var.bucket}"
  acl    = "public-read"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
  }

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = "${aws_s3_bucket.default.id}"
  policy = "${data.aws_iam_policy_document.default.json}"
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
  bucket = "${var.bucket}-logs"
  acl    = "log-delivery-write"
}
