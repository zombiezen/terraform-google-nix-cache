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

output "bucket_name" {
  value = google_storage_bucket.cache.name
}

output "substituter" {
  value       = "s3://${google_storage_bucket.cache.name}?endpoint=https://storage.googleapis.com"
  description = "Nix substituter URL"
}

output "nixcached_substituter" {
  value       = "gs://${google_storage_bucket.cache.name}"
  description = "nixcached substituter URL"
}

output "gcs_hmac_access_key_id" {
  value       = one(google_storage_hmac_key.service_account[*].access_id)
  description = "Access key ID for service account credentials"
}

output "gcs_hmac_secret_access_key" {
  value       = one(google_storage_hmac_key.service_account[*].secret)
  sensitive   = true
  description = "Secret key for service account credentials"
}
