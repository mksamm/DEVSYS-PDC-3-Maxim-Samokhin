## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Создаем Dockerfile
```bash
FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
```
Запускаем сборку образа
```bash
vagrant@vagrant:~/mydockerbuild$ docker build -t mksamm/nginx .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx:latest
latest: Pulling from library/nginx
1fe172e4850f: Pull complete
35c195f487df: Pull complete
213b9b16f495: Pull complete
a8172d9e19b9: Pull complete
f5eee2cb2150: Pull complete
93e404ba8667: Pull complete

Step 2/2 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> 36447e0733b1
Successfully built 36447e0733b1
Successfully tagged mksamm/nginx:latest
```
Запускаем контейнер
```bash
vagrant@vagrant:~/mydockerbuild$ docker run -it -d -p 8080:80 --name nginx mksamm/nginx
vagrant@vagrant:~/mydockerbuild$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS
   NAMES
5bea0881131f   nginx     "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp
vagrant@vagrant:~/mydockerbuild$ sudo docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
nginx         latest    2d389e545974   5 days ago      142MB
hello-world   latest    feb5d9fea6a5   11 months ago   13.3kB
```
Проверяем результат в браузере
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/docker2.PNG)

Присваиваем тег образу
```bash
vagrant@vagrant:~/mydockerbuild$ sudo docker tag  2d389e545974 mksamm/nginx:1.0
vagrant@vagrant:~/mydockerbuild$ sudo docker images
REPOSITORY     TAG       IMAGE ID       CREATED         SIZE
mksamm/nginx   1.0       2d389e545974   5 days ago      142MB
nginx          latest    2d389e545974   5 days ago      142MB
hello-world    latest    feb5d9fea6a5   11 months ago   13.3kB
```
Отправляем в DockerHub
```bash
vagrant@vagrant:~/mydockerbuild$ docker login -u mksamm
Login Succeeded
vagrant@vagrant:~/mydockerbuild$ sudo docker push mksamm/nginx:1.0
The push refers to repository [docker.io/mksamm/nginx]
36665e416ec8: Mounted from library/nginx
31192a8593ec: Mounted from library/nginx
7ee9bf58503c: Mounted from library/nginx
a064c1703bfd: Mounted from library/nginx
9388548487b1: Mounted from library/nginx
b45078e74ec9: Mounted from library/nginx
1.0: digest: sha256:79c77eb7ca32f9a117ef91bc6ac486014e0d0e75f2f06683ba24dc298f9f4dd4 size: 1570
```

Ссылка на репозиторий
<https://hub.docker.com/r/mksamm/nginx>

Решение:
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/docker3.PNG)

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:
- Высоконагруженное монолитное java веб-приложение;

  Виртуальная машина. Так как необходимы производительные мощности напрямую, чтобы все работало в одной системе.

- Nodejs веб-приложение;

  Docker. Простота развертывания данного приложения, требования и затраты к системе минимальны.

- Мобильное приложение c версиями для Android и iOS;

  На мой взгляд подойдет виртуальная машина с графическим интерфейсом. Не требует мощностей от системы, но необходимо удобство отладки.

- Шина данных на базе Apache Kafka;

  Реализуется на Docker, что дает преимущество в простоте разработки и работоспособности.

- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;

  Docker подойдет.

- Мониторинг-стек на базе Prometheus и Grafana;

  Реализуется на Docker,  прекрасно масштабируется и работает.

- MongoDB, как основное хранилище данных для java-приложения;

  Виртуальная машина или физический сервер, так как требуется производительность. Контейнер можно использовать для невысоконагруженных БД

- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

  Реализуется на Docker контейнере при помощи docker-compose.
  
  ## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

Решение:
```
vagrant@vagrant:~/mydockerbuild$ sudo docker run -it -d -v /data:/data --name centos centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
ef3d585f51e84bf3c3d0e29bc710b18674324e59f0506e0365434a4b1fb756e6
vagrant@vagrant:~/mydockerbuild$ sudo docker run -it -d -v /data:/data --name debian debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
23858da423a6: Pull complete
Digest: sha256:3e82b1af33607aebaeb3641b75d6e80fd28d36e17993ef13708e9493e30e8ff9
Status: Downloaded newer image for debian:latest
0bf44c32e7445e2581e86fd9f2619bfb255416c9a60108794ff68db9e5971a12
vagrant@vagrant:~/mydockerbuild$ sudo docker exec -it centos bash
[root@ef3d585f51e8 /]# touch /data/test_centos.txt
[root@ef3d585f51e8 /]# exit
exit
vagrant@vagrant:~/mydockerbuild$ sudo touch /data/test_host.txt
vagrant@vagrant:~/mydockerbuild$ sudo docker exec -it debian bash
root@0bf44c32e744:/# ls /data
test_centos.txt  test_host.txt
root@0bf44c32e744:/# exit
exit
vagrant@vagrant:~/mydockerbuild$
```
