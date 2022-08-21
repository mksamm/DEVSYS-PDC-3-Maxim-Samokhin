# Домашнее задание по лекции "3.8 Компьютерные сети (лекция 3)"
## 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```shell
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
### Решение:
```shell
route-views>sh ip route 178.57.98.102
Routing entry for 178.57.98.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 4w4d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 4w4d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none
route-views>show bgp 178.57.98.102
BGP routing table entry for 178.57.98.0/24, version 2357210148
Paths: (22 available, best #22, table default)
  Not advertised to any peer
  Refresh Epoch 1
  3267 20485 61403
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FDFFBA3ADA0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 1273 20485 61403
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      Community: 1273:12752 1273:30000 20485:10035
      path 7FE143C360B0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 3356 20485 61403
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0534D2C58 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 6453 20485 61403
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30114 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE089621390 RPKI State not found
  ```
     
## 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
### Решение:
```shell
vagrant@vagrant:~$ sudo modprobe -v dummy numdummies=2
insmod /lib/modules/5.4.0-91-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
vagrant@vagrant:~$ sudo ip addr add 192.168.1.150/24 dev dummy0
vagrant@vagrant:~$ sudo ip route add 192.168.1.150 dev eth0
vagrant@vagrant:~$ ip -br route
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
192.168.1.150 dev eth0 scope link
```
## 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

### Решение:
При помощи команд sudo netstat -lnt или sudo ss -ltn проверяем открытые порты - открыты 53 и 22 порт.
22 порт используется для подкдлючения по протоколу SSH, 53 используется Системой доменных имен (DNS)
Например, для удаленного управления операционной системой мы подключаемся к серверу по прокотолу SSH. 

## 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

### Решение:

Можно проверить с помощью команд sudo netstat -lnu или sudo ss -lnu. 
Используются 53 и 68 порты: 
-53 используется Системой доменных имен (DNS) 
-68 клиентом DHCP для получения динимического адреса.

## 5 Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

### Решение:
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/net%20scheme.png)


      


