# terraform-aws-staticsite

```terraform
module "staticsite" {
  source = "github.com/justincampbell/terraform-aws-staticsite"

  bucket = "coolstuff.mydomain.com"
  domain = "mydomain.com"
  host   = "coolstuff" # optional, defaults to "www"
}
```
