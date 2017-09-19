# terraform-aws-staticsite

Creates an AWS S3 bucket configured for website hosting and request logging.

## Example Usage

```terraform
locals {
  domain = "example.com"
}

module "staticsite" {
  source = "github.com/justincampbell/terraform-aws-staticsite"

  bucket = "www.${local.domain}"
  domain = "${local.domain}"
}
```

```shell
$ terraform init
$ terraform plan
```

Then, you can use the outputs for whichever DNS provider you use.

For example, to configure DNSimple to point to this static site:

```terraform
resource "dnsimple_record" "apex" {
  domain = "${local.domain}"
  name   = ""
  type   = "ALIAS"
  value  = "${module.terraform-s3-website.website_endpoint}"
}

resource "dnsimple_record" "www" {
  domain = "${local.domain}"
  name   = "www"
  type   = "URL"
  value  = "http://${local.domain}"
}
```

Or, to configure an apex domain (without a www/hostname):


```terraform
module "staticsite" {
  source = "github.com/justincampbell/terraform-aws-staticsite"

  bucket = "${local.domain}"
  domain = "${local.domain}"
}

resource "dnsimple_record" "apex" {
  domain = "${local.domain}"
  name   = ""
  type   = "ALIAS"
  value  = "${module.staticsite.website_endpoint}"
}

# Redirect www to the root domain
resource "dnsimple_record" "www" {
  domain = "${local.domain}"
  name   = "www"
  type   = "URL"
  value  = "http://${local.domain}"
}
```
