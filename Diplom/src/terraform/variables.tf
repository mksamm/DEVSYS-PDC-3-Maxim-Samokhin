#Токен доступа к yandex.cloud
variable "token" {
  type      = string
  sensitive = true
}

#ID облака
variable "cloud_id" {
  type    = string
  default = "b1gb8tnrcg5uk53e5b74"
}

#ID каталога
variable "folder_id" {
  type    = string
  default = "b1go89oq3fbg6nene4rm"
}
#Белый IP
variable "yc_dedicated_ip" {
  default = "194.58.112.174"
}
#Доменное имя
variable "domain_name" {
  type    = string
  default = "maksam.ru"
}
