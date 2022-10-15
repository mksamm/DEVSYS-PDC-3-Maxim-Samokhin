## Данный плейбук автоматизирует установки:

- На 1 машину Эластик
- На 2 машину Кибану.
- На обе машины java SDK

## Требования:

- Ubuntu 20.04

## Зависимости:

- Требуется поместить в `./playbook/files`  предварительно скачанные пакеты.
  - Пример:
    - https://artifacts.elastic.co/downloads/kibana/kibana-8.0.0-linux-x86_64.tar.gz
    - https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-linux-x86_64.tar.gz


## Параметры

`Параметры скачиваняи пакета джавы`
```bash
   - name: Set facts for Java 11 vars
      set_fact:
        java_home: "/opt/jdk/{{ java_jdk_version }}"        # Домашняя папка  (Я бы пернес в переменные) 
      tags: java
    - name: Download java from remote URL
      get_url:
        url: "https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.15%2B10/OpenJDK11U-jdk_x64_linux_11.0.15_10.tar.gz"   # Скачивание пакета с гитхаба
        dest: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: download_java_binaries
      until: download_java_binaries is succeeded
      tags: java
```

`playbook/group_vars/all/vars.yml`
```yml
java_jdk_version: "11.0.16.1"                                 # Номер версии зависимость с java_home
```


`playbook/group_vars/elasticsearch/vars.yml`
```yml
elastic_version: "7.10.1"                                   # Номер требуемой версии для установки (лучше указать реальный номер исходя из устанавливаемого пакета)
elastic_package: elasticsearch-7.10.1-linux-x86_64.tar.gz   # Имя пакета для установки в папке files
elastic_home: "/opt/elastic/{{ elastic_version }}"          # Домашняя папка
```

`playbook/group_vars/kibana/vars.yml`
```yml
kibana_version: "7.10.1"                                   #Номер требуемой версии для установки (лучше указать реальный номер исходя из устанавливаемого пакета)
kibana_package: "kibana-8.0.0-linux-x86_64.tar.gz"         # Имя пакета для установки в папке files
kibana_home: "/opt/kibana/{{ kibana_version }}"            # Домашняя папка
```
