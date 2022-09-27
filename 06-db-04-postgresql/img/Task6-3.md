# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL0.PNG)

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL1.PNG)

**Найдите и приведите** управляющие команды для:
- вывода списка БД
>`\l`
- подключения к БД
>`\c <database>`
- вывода списка таблиц
>`\dt *.*`
- вывода описания содержимого таблиц
>`\d`
- выхода из psql
>`\q`

## Задача 2

Используя `psql` создайте БД `test_database`.

>`CREATE DATABASE test_database;`

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL2.PNG)

Перейдите в управляющую консоль `psql` внутри контейнера.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL3.PNG)

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL4.PNG)
