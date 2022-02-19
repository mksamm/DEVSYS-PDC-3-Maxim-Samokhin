1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout.

Ответ: системный вызов chdir ("/tmp")

2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
vagrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

Ответ: /usr/share/misc/magic.mgc

3.Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

Моделируем ситуацию dd if=/dev/zero of=./file01 & lsof -p 2543 rm file01 lsof -p 2543 ls -l /proc/2543/fd

Ответ:

1)truncate -s 0 /proc/2543/fd/1

2)echo ' ' > file01

4.Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Ответ: Зомби-процессы не занимают памяти, но блокируют записи в таблице процессов.

5. В iovisor BCC есть утилита opensnoop:
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

Ответ:
vagrant@vagrant:~$ sudo apt-get install bpfcc-tools linux-headers-$(uname -r)
...
vagrant@vagrant:~$ sudo opensnoop-bpfcc

PID    COMM               FD ERR PATH
808    vminfo              4   0 /var/run/utmp
625    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
625    dbus-daemon        18   0 /usr/share/dbus-1/system-services
625    dbus-daemon        -1   2 /lib/dbus-1/system-services
625    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
808    vminfo              4   0 /var/run/utmp
625    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
625    dbus-daemon        18   0 /usr/share/dbus-1/system-services
625    dbus-daemon        -1   2 /lib/dbus-1/system-services
625    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
635    irqbalance          6   0 /proc/interrupts
635    irqbalance          6   0 /proc/stat
635    irqbalance          6   0 /proc/irq/20/smp_affinity
635    irqbalance          6   0 /proc/irq/0/smp_affinity
635    irqbalance          6   0 /proc/irq/1/smp_affinity
635    irqbalance          6   0 /proc/irq/8/smp_affinity
635    irqbalance          6   0 /proc/irq/12/smp_affinity
635    irqbalance          6   0 /proc/irq/14/smp_affinity
635    irqbalance          6   0 /proc/irq/15/smp_affinity
808    vminfo              4   0 /var/run/utmp
625    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
625    dbus-daemon        18   0 /usr/share/dbus-1/system-services
625    dbus-daemon        -1   2 /lib/dbus-1/system-services
625    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
...

6.Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

Ответ: uname -a использует системный вызов uname альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС, цитата из MAN 2 Uname: Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.

7.Чем отличается последовательность команд через ; и через && в bash? Например:
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
Есть ли смысл использовать в bash &&, если применить set -e?

Ответ:
; — последовательное выполнение команд. сообщение Hi выведется в любом случае.

&& — логическое И; Hi выведется в случае если существует директория /tmp/some_dir.

8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

Режим bash set -euxo pipefail состоит из следующих опций:

-e When this option is on, if a simple command fails for any of the reasons listed in Consequences of Shell Errors or returns an exit status value >0, and is not part of the compound list following a while, until, or if keyword, and is not a part of an AND or OR list, and is not a pipeline preceded by the ! reserved word, then the shell shall immediately exit.

-u The shell shall write a message to standard error when it tries to expand a variable that is not set and immediately exit. An interactive shell shall not exit.

-x The shell shall write to standard error a trace for each command after it expands the command and before it executes it. It is unspecified whether the command that turns tracing off is traced.

-o Write the current settings of the options to standard output in an unspecified format.

+o Write the current option settings to standard output in a format that is suitable for reinput to the shell as commands that achieve the same options settings.

9.Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

Ответ:

vagrant@vagrant:~$ ps -o stat
STAT
Ss
T
T
T
R+

Ss - ожидает события для завершения, лидер текущего сеанса
T - остановлен сигналом
R+ - запущен, в foreground
