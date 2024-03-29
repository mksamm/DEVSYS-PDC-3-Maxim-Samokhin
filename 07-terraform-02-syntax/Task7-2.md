# Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."

Выполнял Вариант с Yandex.Cloud

## Задача 1 Регистрация в ЯО и знакомство с основами (необязательно, но крайне желательно).

1. Подробная инструкция на русском языке содержится [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
2. Обратите внимание на период бесплатного использования после регистрации аккаунта. 
3. Используйте раздел "Подготовьте облако к работе" для регистрации аккаунта. Далее раздел "Настройте провайдер" для подготовки
базового терраформ конфига.
4. Воспользуйтесь [инструкцией](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) на сайте терраформа, что бы 
не указывать авторизационный токен в коде, а терраформ провайдер брал его из переменных окружений.

Конфигурационные файлы Terraform \
[main.tf](./src/main.tf) \
[versions.tf](./src/versions.tf)

## Задача 2. Создание yandex_compute_instance через терраформ. 

1. В каталоге `terraform` вашего основного репозитория, который был создан в начале курсе, создайте файл `main.tf` и `versions.tf`.

2. Зарегистрируйте провайдер 

   1. для [yandex.cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs). 
   
   Подробную инструкцию можно найти [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
   
3. Внимание! В гит репозиторий нельзя пушить ваши личные ключи доступа к аккаунту. Поэтому в предыдущем задании мы указывали
их в виде переменных окружения. 

4. В файле `main.tf` воспользуйтесь блоком `data "aws_ami` для поиска ami образа последнего Ubuntu.  
5. В файле `main.tf` создайте рессурс 
   1. либо [ec2 instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance).
   Постарайтесь указать как можно больше параметров для его определения. Минимальный набор параметров указан в первом блоке 
   `Example Usage`, но желательно, указать большее количество параметров.
   2. либо [yandex_compute_image](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image).
6. Также в случае использования aws:
   1. Добавьте data-блоки `aws_caller_identity` и `aws_region`.
   2. В файл `outputs.tf` поместить блоки `output` с данными об используемых в данный момент: 
       * AWS account ID,
       * AWS user ID,
       * AWS регион, который используется в данный момент, 
       * Приватный IP ec2 инстансы,
       * Идентификатор подсети в которой создан инстанс.  
7. Если вы выполнили первый пункт, то добейтесь того, что бы команда `terraform plan` выполнялась без ошибок. 


В качестве результата задания предоставьте:

1. Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?

Amazon AMI Builder плагин c помощью инструмента [Packer](https://www.packer.io/plugins/builders/amazon) 
Этот инструмент позволяет создавать образы AMI. 
Также с помощью встроенных средств Amazon Web Services можно создать AMI  из работающего инстанса.

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/07-terraform-02-syntax/tf2.PNG)

2. Ссылку на репозиторий с исходной конфигурацией терраформа.
 
<https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/tree/main/07-terraform-02-syntax/src>

