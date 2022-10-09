provider "yandex" {
  cloud_id  = "b1gb8tnrcg5uk53e5b74"
  folder_id = "b1gopdq3h799jne7ns71"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "centos" {
  family = "centos-stream-8"
  folder_id = "standard-images"
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "netology-1" {
  name = "netology-1"
  hostname = "netology-1"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      name = "netology-1-boot"
      image_id = "${data.yandex_compute_image.centos.id}"
    }
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
}
