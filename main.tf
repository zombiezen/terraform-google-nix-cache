# Copyright 2023 Ross Light
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_version = "~> 1.0"

  required_providers {
    google = {
      version = "~> 4.0"
    }
  }
}

resource "google_project_service" "storage" {
  project            = var.project
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "cache" {
  project       = var.project
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 2
      with_state         = "ARCHIVED"
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      days_since_noncurrent_time = 7
    }
  }

  depends_on = [
    google_project_service.storage
  ]
}

resource "google_storage_hmac_key" "service_account" {
  count                 = var.service_account_email != "" ? 1 : 0
  service_account_email = var.service_account_email
  project               = var.service_account_project

  depends_on = [
    google_project_service.storage
  ]
}

resource "google_storage_bucket_iam_member" "service_account_admin" {
  count  = var.service_account_email != "" ? 1 : 0
  bucket = google_storage_bucket.cache.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.service_account_email}"
}
