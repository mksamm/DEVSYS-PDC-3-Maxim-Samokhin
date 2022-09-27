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

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```
START TRANSACTION;
CREATE TABLE orders_new (LIKE orders INCLUDING DEFAULTS) PARTITION BY RANGE (price);
CREATE TABLE orders_1 PARTITION OF orders_new FOR VALUES FROM (MINVALUE) TO (499);
CREATE TABLE orders_2 PARTITION OF orders_new FOR VALUES FROM (499) TO (MAXVALUE);
INSERT INTO orders_new SELECT * FROM orders;
ALTER TABLE orders RENAME TO orders_old;
ALTER TABLE orders_new RENAME TO orders;
COMMIT;


postgres=# \c test_database
You are now connected to database "test_database4" as user "postgres".
test_database=# START TRANSACTION;
START TRANSACTION
test_database=*# CREATE TABLE orders_new (LIKE orders INCLUDING DEFAULTS) PARTITION BY RANGE (price);
CREATE TABLE
test_database=*# CREATE TABLE orders_1 PARTITION OF orders_new FOR VALUES FROM (MINVALUE) TO (499);
CREATE TABLE
test_database=*# CREATE TABLE orders_2 PARTITION OF orders_new FOR VALUES FROM (499) TO (MAXVALUE);
CREATE TABLE
test_database=*# INSERT INTO orders_new SELECT * FROM orders;
INSERT 0 8
test_database=*# ALTER TABLE orders RENAME TO orders_old;
ALTER TABLE
test_database=*# ALTER TABLE orders_new RENAME TO orders;
ALTER TABLE
test_database=*# COMMIT;
COMMIT
```

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/06-db-04-postgresql/img/PostSQL5.PNG)

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Можно! Во время проектирования таблицы необходимо сразу назначать секционирование, в таком случае отсутствует необходимость переносить данные.

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```
postgres@33b6e65dfde1:~$ pg_dump -U postgres -d test_database >test_database_backup.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```
Можно добавить параметр первичного ключа при определении поля title, заменив `NOT NULL` на `PRIMARY KEY`. 
Добавить параметр `UNIQUE` для поля.
```
