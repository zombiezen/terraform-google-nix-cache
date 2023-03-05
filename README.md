# Terraform for Nix Cache backed by Google Cloud Storage

This is a Terraform module to create a Google Cloud Storage (GCS) bucket
that can be used as a [Nix binary cache](https://nixos.org/manual/nix/stable/package-management/s3-substituter.html).

## Example

```terraform
terraform {
  required_version = "~> 1.0"
}

provider "google" {
  project = "PROJECTID"
}

module "nix_cache" {
  source  = "zombiezen/nix-cache/google"
  version = "0.1.0"

  bucket_name     = "BUCKETNAME"
  bucket_location = "us"

  # Optional:
  service_account_email   = google_service_account.github_actions.email
  service_account_project = google_service_account.github_actions.project
}

# Optional:
resource "google_service_account" "github_actions" {
  account_id   = "github"
  display_name = "GitHub Actions"
  description  = "GitHub Actions runners"
}
```

## License

[Apache 2.0](LICENSE)
