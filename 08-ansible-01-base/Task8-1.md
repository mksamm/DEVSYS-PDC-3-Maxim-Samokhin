# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.
![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible1.PNG)
2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
   Ссылка на собственный [репозиторий в GitHub](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/tree/main/08-ansible-01-base/playbook)
   ## Основная часть
   
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.

![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible2.PNG)

2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.

![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible16.PNG)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible4.PNG)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

   ```
   $ ansible-playbook site.yml -i inventory/prod.yml
   ```
   
![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible5.PNG)

![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible6.PNG)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: 
для `deb` - 'deb default fact', 
для `el` - 'el default fact'.

```
$ cat group_vars/deb/examp.yml
---
  some_fact: "deb default fact"
$ cat group_vars/el/examp.yml
---
  some_fact: "el default fact"
```
![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible7.PNG)

6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
   
   ```
   $ ansible-playbook site.yml -i inventory/prod.yml
   ```
   ![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible8.PNG)
   
 7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
 
 ![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible9.PNG)
 
 8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

 ![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible10.PNG)
 
 ![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible11.PNG)
 
 ![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/ansible12.PNG)
 
 9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
 ```
$ ansible-doc -t connection local

   > ANSIBLE.BUILTIN.LOCAL    (/usr/lib/python3/dist-packages/ansible/plugins/connection/local.py)
   This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a remote host.
   NOTES:
         * The remote user is ignored, the user with which the ansible CLI was executed is used instead.
   AUTHOR: ansible (@core)
   VERSION_ADDED_COLLECTION: ansible.builtin
 ```
   10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
    Добавляем в файл inventory/prod.yml следующий код:
    ```
      el:
        hosts:
          centos7:
            ansible_connection: docker
      deb:
        hosts:
          ubuntu:
            ansible_connection: docker
      local:
        hosts:
          localhost:
            ansible_connection: local

 
 11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

    Запускаем команду:

    ```
    $ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
    ```
    
![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible13.PNG)
![image.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/08-ansible-01-base/images/Ansible14.PNG)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

    Ссылка на [README.md](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/tree/main/08-ansible-01-base/playbook)
