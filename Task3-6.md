# Решение домашней работы

1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
```bash
# telnet stackoverflow.com 80
Connection to stackoverflow.com:80 - ok
```
- отправьте HTTP запрос
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
Ответ
```http request
# GET /questions HTTP/1.0
HTTP/1.1 301 Moved Permanently  показывает, что запрошенный ресурс был окончательно перемещён
# HOST: stackoverflow.com
```
![alt tag](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/3-6-1.png)
- В ответе укажите полученный HTTP код, что он означает?
```
HTTP/1.1 301 Moved Permanently  показывает, что запрошенный ресурс был окончательно перемещён
```
---
2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

```
Наиболее продолжительные ответы отфильтрованы
```
![alt tag](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/3-6-2.png)

---
3. Какой IP адрес у вас в интернете?
```
109.252.х.х динамический сообщить полностью считаю не безопасным.
```
---
4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`
```
MGTS
route: 109.252.0.0/16
descr: Moscow Local Telephone Network (OAO MGTS)
origin: AS25513
mnt-by: MGTS-USPD-MNT

source: RIPE # Filtered
```
![alt tag](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/3-6-4.png)
---
5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`


```
  https://sun9-31.userapi.com/impg/0fyZgjig5V4A4RPcmGlS4bbahTfNJLMsUhlQ4w/n_snNanLQbc.jpg?size=795x603&quality=96&sign=4206c5f004d92352730f4a0064e675bd&type=album
```
---
6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?
```
Наибольшая задержка 216.239.51.32
```
![alt tag](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/3-6-6.png)
---

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`

**DNS сервера:**

* ns3.zdns.google.
* ns1.zdns.google.
* ns2.zdns.google.
* ns4.zdns.google.
```bash
vagrant@vagrant:~$ dig -t ns dns.google
; <<>> DiG 9.16.1-Ubuntu <<>> -t ns dns.google
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 29499
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1
;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.                    IN      NS
;; ANSWER SECTION:
dns.google.             8854    IN      NS      ns3.zdns.google.
dns.google.             8854    IN      NS      ns1.zdns.google.
dns.google.             8854    IN      NS      ns2.zdns.google.
dns.google.             8854    IN      NS      ns4.zdns.google.
;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Wed Dec 15 22:08:15 UTC 2021
;; MSG SIZE  rcvd: 116
```
A-записи:
* 8.8.4.4
* 8.8.8.8
```bash
vagrant@vagrant:~$ dig dns.google
; <<>> DiG 9.16.1-Ubuntu <<>> dns.google
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 1450
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1
;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.                    IN      A
;; ANSWER SECTION:
dns.google.             640     IN      A       8.8.4.4
dns.google.             640     IN      A       8.8.8.8
;; Query time: 12 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Wed Dec 15 22:10:12 UTC 2021
;; MSG SIZE  rcvd: 71
```
8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`
```bash
vagrant@vagrant:~$ dig -x 216.239.34.114 +short
ns2.zdns.google.
```
В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов.
