# Решение домашнего задания к занятию "6.3. MySQL"



## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

-Файл docker-compose.yml

```
version: '3.1'
services:
  db:
    image: mysql
    container_name: netology
    environment:
      MYSQL_ROOT_PASSWORD: root
    ports:
      - "3306:3306"
    volumes:
      - dbdata:/var/lib/mysql
volumes:
  dbdata:
```
-Запускаем docker-compose up и проверяем запущенный контейнер:

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL31.PNG)

-Заходим в контейнер MySQL и проверяем работоспособность командами:

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL32.PNG)

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и восстановитесь из него.

```
netology@netology-VirtualBox:~/netology/DEVSYS-PDC-3-Maxim-Samokhin/edit/main/Task6-3$ sudo docker cp test_dump.sql ed89d4a2d9ed:/var/lib/mysql/test_dump.sql
```
