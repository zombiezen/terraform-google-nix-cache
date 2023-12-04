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

variable "project" {
  default     = ""
  description = "(Optional) GCP Project ID to use if different than google provider project"
}

variable "bucket_name" {
  type        = string
  description = "Nix cache bucket name"
}

variable "bucket_location" {
  type        = string
  description = "Google Cloud Storage location (see https://cloud.google.com/storage/docs/locations)"
}

variable "service_account_email" {
  default     = ""
  description = "(Optional) Name of service account to grant read and write access to"
}

variable "service_account_project" {
  default     = ""
  description = "(Optional) Project ID of service account to grant read and write access to, if different than google provider project"
}

variable "hmac_key" {
  default = true
  description = "Generate an HMAC key if a service account is created."
}
