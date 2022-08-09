# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
## 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
* поместите его в автозагрузку,
* предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
* удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

### Решение:
1. Скачен архив `wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz`
2. Распакован в `/opt/node_exporter`
3. Создан файл конфигурации сервиса `touch /etc/systemd/system/node_exporter.service` со следующим содержимым:

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-4.PNG)

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-42.PNG)

4. Для добавления переменных из файла записана опция `EnvironmentFile=/etc/default/node_exporter` а так же создан данный файл `touch /etc/default/node_exporter`
5. Командой `systemctl enable node_exporter` сервис добавлен в автозагрузку
6. Командами `systemctl start node_exporter` `systemctl stop node_exporter` `systemctl status node_exporter` проверена корректность старта и завершения сервиса
7. После перезагрузки командой `systemctl status node_exporter` убедились что сервис запустился автоматически:

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-43.PNG)

ИСТОРИЯ КОММАНД: 
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-44.PNG)

## 2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
### Решение:
Для просмотра метрик можно использовать команду `curl localhost:9100/metrics`
### Ответ:
Node CPU:
```
    node_cpu_seconds_total{cpu="0",mode="idle"} 
    node_cpu_seconds_total{cpu="0",mode="system"} 
    node_cpu_seconds_total{cpu="0",mode="user"}
    node_cpu_seconds_total{cpu="1",mode="idle"} 
    node_cpu_seconds_total{cpu="1",mode="system"} 
    node_cpu_seconds_total{cpu="1",mode="user"}
    process_cpu_seconds_total
```
Node Memory:
```
    node_memory_MemAvailable_bytes 
    node_memory_MemFree_bytes
```
Node Disk:
```
    node_disk_io_time_seconds_total{device="sda"} 
    node_disk_read_time_seconds_total{device="sda"} 
    node_disk_write_time_seconds_total{device="sda"}
```
Node Network:
```
    node_network_receive_errs_total{device="eth0"} 
    node_network_receive_bytes_total{device="eth0"} 
    node_network_transmit_bytes_total{device="eth0"}
    node_network_transmit_errs_total{device="eth0"}
```
## 3. Установите в свою виртуальную машину `Netdata`. Воспользуйтесь готовыми пакетами для установки (`sudo apt install -y netdata`). После успешной установки:
* в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с `localhost` на `bind to = 0.0.0.0`,
* добавьте в Vagrantfile проброс порта `Netdata` на свой локальный компьютер и сделайте `vagrant reload`:
`config.vm.network "forwarded_port", guest: 19999, host: 19999`
### Решение:
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-45.PNG)

## 4. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Ответ:
Да, операционная система понимает что запущена в виртуальной среде

## 5. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

### Решение: 
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-46.PNG)

Ответ:
Данный параметр отвечает за максимальное количество открытых файлов, лимит открытых файлов на пользователя не позволит достичь данного числа одним пользователем.

## 6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

### Решение: 
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%9D%D0%B5%D1%82%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%8F3-47.PNG)

## 7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?
### Ответ:
`:(){ :|:& };:` - создает функцию `:` которая уходит в фон и создает саму себя снова, получается бесконечная рекурсия с порождением все новых и новых процессов

Стабилизации помог механизм `[ 1872.274270] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope`

По умолчанию число процессов ограничено 3571 (`ulimit -u`) изменить их количество можно командой `ulimit -u <pid-count>`
