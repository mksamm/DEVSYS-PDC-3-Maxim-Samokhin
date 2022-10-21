output "External_IP_Address_maksam" {
  value = yandex_compute_instance.maksam.network_interface.0.nat_ip_address
}
