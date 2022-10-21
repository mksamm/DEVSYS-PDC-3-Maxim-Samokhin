#Токен доступа к yandex.cloud
variable "token" {
  type      = string
  sensitive = true
}

#ID облака
variable "cloud_id" {
  type    = string
  default = ""
}

#ID каталога
variable "folder_id" {
  type    = string
  default = ""
}
#Белый IP
variable "yc_dedicated_ip" {
  default = ""
}
#Доменное имя
variable "domain_name" {
  type    = string
  default = "maksam.ru"
}
