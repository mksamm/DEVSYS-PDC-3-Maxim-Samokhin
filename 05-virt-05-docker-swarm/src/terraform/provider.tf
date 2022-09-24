# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "y0_AgAAAAAj9_U2AATuwQAAAADPYgt1MS8QZD5DSA6f2Niyy7u4n5oaDLc"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}
