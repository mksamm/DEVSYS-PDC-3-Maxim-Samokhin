resource "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "default-ru-central1-c" {
  name           = "default-ru-central1-c"
  zone           = "ru-central1-c"
  network_id     = "enp1v6482kpcg6nklssj"
  v4_cidr_blocks = ["10.130.0.0/24"]
}

resource "yandex_vpc_subnet" "my-subnet-a" {
  name           = "my-subnet-a"
  zone           = "ru-central1-a"
  network_id     = "enp1v6482kpcg6nklssj"
  v4_cidr_blocks = ["10.1.2.0/24"]
}
