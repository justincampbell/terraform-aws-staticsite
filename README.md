# terraform-s3-website

```terraform
module "terraform-s3-website" {
  source = "github.com/justincampbell/terraform-s3-website"

  bucket = "coolstuff.mydomain.com"
  domain = "mydomain.com"
  host   = "coolstuff" # optional, defaults to "www"
}
```
