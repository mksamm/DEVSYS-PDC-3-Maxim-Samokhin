resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.
    [nodes:children]
    managers
    workers
    [managers:children]
    active
    standby
    [active]
    node01.netology.yc ansible_host=${yandex_compute_instance.node01.network_interface.0.nat_ip_address}
    [standby]
    node02.netology.yc ansible_host=${yandex_compute_instance.node02.network_interface.0.nat_ip_address}
    node03.netology.yc ansible_host=${yandex_compute_instance.node03.network_interface.0.nat_ip_address}
    [workers]
    node04.netology.yc ansible_host=${yandex_compute_instance.node04.network_interface.0.nat_ip_address}
    node05.netology.yc ansible_host=${yandex_compute_instance.node05.network_interface.0.nat_ip_address}
    node06.netology.yc ansible_host=${yandex_compute_instance.node06.network_interface.0.nat_ip_address}
    DOC
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.node01,
    yandex_compute_instance.node02,
    yandex_compute_instance.node03,
    yandex_compute_instance.node04,
    yandex_compute_instance.node05,
    yandex_compute_instance.node06
  ]
}
