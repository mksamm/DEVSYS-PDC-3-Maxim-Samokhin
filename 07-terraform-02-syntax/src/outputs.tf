output "yandex_compute_image" {
  value = data.yandex_compute_image.centos.id
}

data "yandex_client_config" "client" {}
output "zone" {
  value = data.yandex_client_config.client.zone
}
output "cloud_id" {
  value = data.yandex_client_config.client.cloud_id
}
output "folder_id" {
  value = data.yandex_client_config.client.folder_id
}

output "network" {
  value = yandex_vpc_network.network-1.name
}

output "internal_ip_address_netology_1" {
  value = yandex_compute_instance.netology-1.network_interface.0.ip_address
}
