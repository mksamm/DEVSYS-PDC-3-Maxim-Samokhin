# Решение домашнего задания к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

Подготавливаем файл docker-compose.yml

```
version: '3.8'
services:
  db:
    image: postgres:12-alpine
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes:
      - db:/var/lib/postgresql/data
      - backup:/var/tmp
volumes:
  db:
    driver: local
  backup:
```

Запускаем docker-compose up и проверяем запущенный контейнер:

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL21.PNG)

Заходим в контейнер и PostgreSQL:
```
vagrant@vagrant:~/DEVSYS-PDC-3-Maxim-Samokhin/Task6-2$ sudo docker exec -it task6-2-db-1 /bin/sh
/ # su - postgres
85a102f9fb91:~$ psql
psql (12.12)
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db

  ```
  CREATE DATABASE test_db;
  CREATE USER test_admin_user WITH PASSWORD 'admin';

- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)

  ```
  CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  наименование TEXT,
  цена INT
  );
  
  CREATE TABLE clients (
      id SERIAL PRIMARY KEY,
      фамилия TEXT,
      страна_проживания TEXT,
      заказ INT,
      FOREIGN KEY (заказ) REFERENCES orders (id)
  );

- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db

  ```
  GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test_admin_user;

- создайте пользователя test-simple-user  

  ```
  CREATE USER test_simple_user WITH PASSWORD 'simple';

- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

  ```
  GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO test_simple_user;

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL22.PNG)

- описание таблиц 

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL23.PNG)

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

- список пользователей с правами над таблицами test_db

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL24.PNG)

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

```
INSERT INTO orders (наименование, цена)
  VALUES
  ('Шоколад', 10),
  ('Принтер', 3000),
  ('Книга',   500),
  ('Монитор', 7000),
  ('Гитара',  4000);
```



Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

```
INSERT INTO clients (фамилия, страна_проживания)
  VALUES
  ('Иванов Иван Иванович', 'USA'),
  ('Петров Петр Петрович', 'Canada'),
  ('Иоганн Себастьян Бах', 'Japan'),
  ('Ронни Джеймс Дио', 'Russia'),
  ('Ritchie Blackmore', 'Russia');
```



Используя SQL синтаксис:

- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```
test_db=# SELECT COUNT(*) FROM orders;
 count
-------
     5
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count
-------
     5
(1 row)

test_db=#

```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL25.PNG)

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

```
test_db=# EXPLAIN SELECT * FROM clients WHERE заказ IS NOT NULL;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
(2 rows)
test_db=# EXIT
85a102f9fb91:~$ exit
```

Оценка стоимости выполнения данного плана.

-  (0.00) Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.
- (18.10)Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки. На практике родительский узел может досрочно прекратить чтение строк дочернего (см. приведённый ниже пример с `LIMIT`).
- (806) Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.
- (72) Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

```
vagrant@vagrant:~/DEVSYS-PDC-3-Maxim-Samokhin/Task6-2$ sudo docker exec -it 85a102f9fb91 /bin/sh
/ # su - postgres
85a102f9fb91:~$ pg_dump -U postgres -p 5432 --format=custom test_db -f /var/tmp/test_db.backup
```

Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
vagrant@vagrant:~/DEVSYS-PDC-3-Maxim-Samokhin/Task6-2$ sudo docker stop 85a102f9fb91
85a102f9fb91
vagrant@vagrant:~/DEVSYS-PDC-3-Maxim-Samokhin/Task6-2$ sudo docker volume ls
DRIVER    VOLUME NAME
local     f555e1ed85d3b32dd381d2712caa43c679d7747cba838422c44a9d38cefea94b
local     fbb07aaf1879cbd98321367d4501a8b804266ff01679cb252344bdeb98320dc6
local     task6-2_backup
local     task6-2_db
```
Поднимите новый пустой контейнер с PostgreSQL.

Создадим новый docker-compose.yml со следующим содержимым:

```
version: '3.8'
services:
  db:
    image: postgres:12-alpine
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes:
      - backup:/var/tmp
volumes:
  backup:
```

Запускаем docker-compose up и проверяем запущенный контейнер:
```
vagrant@vagrant:~$ sudo docker ps
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                                       NAMES
6a960d9011f5   postgres:12-alpine   "docker-entrypoint.s…"   50 seconds ago   Up 48 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   task6-2-db-1
```
Заходим в PostgreSQL:
```
vagrant@vagrant:~$ sudo docker exec -it 6a960d9011f5 /bin/sh
/ # su - postgress
su: unknown user postgress
/ # su - postgres
6a960d9011f5:~$ psql
psql (12.12)
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```

Восстановите БД test_db в новом контейнере.

Добавляем пользователей:
```
postgres=# CREATE USER test_admin_user WITH PASSWORD 'admin';
CREATE ROLE
postgres=# CREATE USER test_simple_user WITH PASSWORD 'simple';
CREATE ROLE
```

Используем утилиту pg_restore предназначенная для восстановления базы данных PostgreSQL из архива, созданного командой pg_dump и восстанавливаем базу test_db в PostgreSQL:
```
6a960d9011f5:~$ pg_restore --create --file=/var/tmp/pg_restore.script /var/tmp/test_db.backup
6a960d9011f5:~$ ls /var/tmp/
pg_restore.script  test_db.backup
6a960d9011f5:~$ psql -f /var/tmp/pg_restore.script
```

Проверяем восстановленную базу test_db: 

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-2/SQL26.PNG)
