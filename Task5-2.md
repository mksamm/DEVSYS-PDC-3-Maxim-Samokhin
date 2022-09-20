# Решение домашнего задания к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

---

## Задача 1

- <u>Опишите своими словами основные преимущества применения на практике IaaC паттернов.</u>

-Быстрое развертывание на всех этапах жизненного цикла продукта.

-Высокая скорость и безопасность.

-Возможность внесение всех изменений, отслеживания истории изменений и восстановления.


- <u>Какой из принципов IaaC является основополагающим?</u>

Идемпотентность, способность данной операции всегда производить один и тот же результат, является важным принципом IaC. Команда развертывания всегда устанавливает целевую среду в одну и ту же конфигурацию независимо от начального состояния среды. 
Идемпотентность достигается путем автоматической настройки существующего целевого объекта или путем отмены существующего целевого объекта и повторного создания новой среды. Возможность описать желаемое состояние того, что  конфигурируется, с определённой гарантией что оно будет достигнуто.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?

Скорость - бустрый старт на текущей SSH инфраструктуре;

Проста - декларативный метод написания конфигурации. Синтаксис playbook на языке Yaml

Расширяемость - легкое подключение кастомных ролей и модулей

- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

По моему надежнее Push так как не требует установки ни демонов, ни агентов, в случае с pull методом такие агенты нужны.
При развёртывании серверов очень просто автоматизируется и вписывается в философию Infrastructure as a Code.

## Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

VirtualBox

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%92%D0%B5%D1%80%D1%81%D0%B8%D1%8FVbox.PNG)


Vagrant


![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%92%D0%B5%D1%80%D1%81%D0%B8%D1%8F%20Vagrant.PNG)


Ansible

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/%D0%92%D0%B5%D1%80%D1%81%D0%B8%D1%8F%20Ansible.PNG)
