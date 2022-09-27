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

Восстанавливаем бэкап в MySQL

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL34.PNG)

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL35.PNG)

Используя команду `\h` получите список управляющих команд.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sql36.PNG)

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

```
mysql> \s
```

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sqL37.PNG)

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL38.PNG)

**Приведите в ответе** количество записей с `price` > 300.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL39.PNG)

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"


Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
приведите в ответе к задаче.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/SQL321.PNG)

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sql42.PNG)

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sql43.PNG)

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sql44.PNG)

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Task6-3/img/sql45.PNG)

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

!includedir /etc/mysql/conf.d/
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 1200M
innodb_log_file_size = 100M
```
