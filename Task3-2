1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.

Ответ: Команда cd (change directory) встроенная команда shell для изменения текущей директории. Не является файлом/процессом. Таким образом есть тип встроенных (builtin) команд, среди которых cd.

2.Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?  Ответ: grep -c <some_string> <some_file>. Флаг -c выводит количество строк в которых найдены совпадения строки.

3.Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?  Ответ: Процесс systemd

4.Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала? Ответ: 

Путь текущего терминала:

vagrant@vagrant:~$ tty
/dev/pts/0

Для второй сессии путь /dev/pts/1:

vagrant@vagrant:~$ tty
/dev/pts/1

Команда vagrant ssh и направляем поток std out по пути /dev/pts/0 to /dev/pts/1:

Ответ:
vagrant@vagrant:~$ ls > /dev/pts/1
vagrant@vagrant:~$
-------
vagrant@vagrant:~$ loco2.txt  loco.txt

5.Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? 
Ответ: cat < loco.txt > loco2.txt

6.Получится ли находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
Ответ: Получится! echo '300 bucks' > /dev/pts/1

7.Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
Ответ: bash 5>&1 создаёт дескриптор с условным номером 5 и связывает его с std out текущего процесса. Появилось слово netology.

8.Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? 
Получится помощью команды ls dir 5>&2 2>&1 | grep dir Направляем созданный 5 дескриптор на 2, а 2 на 1

9.Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
Ответ: Команда выводит переменные окружения текущей сессии. Можно получить аналогичный по содержанию вывод командой env.

10.Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.
Ответ: 
man proc | grep -n -B 1 -A 2 cmdline
man proc | grep -n -B 1 -A 2 exe

194:       /proc/[pid]/cmdline
195-              This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing
196-              in  this  file: that is, a read on this file will return 0 characters.  The command-line arguments appear in this file as a set of strings

241:       /proc/[pid]/exe
242:              Under Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be
243:              dereferenced normally; attempting to open it will open the executable.  You can even type /proc/[pid]/exe to run another copy of the  same
244:              executable  that  is being run by process [pid].  If the pathname has been unlinked, the symbolic link will contain the string '(deleted)'
245-              appended to the original pathname.  In a multithreaded process, the contents of this symbolic link are not available if  the  main  thread
246-              has already terminated (typically by calling pthread_exit(3)).

файл с полной командной строкой для процесса - /proc/<PID>/cmdline
файл, с ссылкой на фактический путь к процессу - /proc/<PID>/exe

11.Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo. 
Ответ: SSE 4.2

12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:

vagrant@netology1:~$ ssh localhost 'tty'
not a tty
Почитайте, почему так происходит, и как изменить поведение.

Ответ: для запуска можно добавить флаг -t в таком случае команда исполняется c принудительным созданием эмуляторатерминальной линии 
ssh -t localhost 'tty'

13.Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.

Ответ: 
vagrant@vagrant:~$ tty
/dev/pts/0
vagrant@vagrant:~$ top
top - 23:01:15 up 1 min,  1 user,  load average: 0.32, 0.14, 0.05
Tasks: 130 total,   1 running, 129 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  1.5 sy,  0.0 ni, 98.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   1987.1 total,   1381.4 free,    129.8 used,    475.9 buff/cache
MiB Swap:    980.0 total,    980.0 free,      0.0 used.   1697.8 avail Mem
..................
[1]+  Stopped                 top
vagrant@vagrant:~$ ps -a
    PID TTY          TIME CMD
   1227 pts/0    00:00:00 top
   1228 pts/0    00:00:00 ps
   
vagrant@vagrant:~$ screen -S 1227

vagrant@vagrant:~$ sudo reptyr 1227
Unable to attach to pid 1227: Operation not permitted

vagrant@vagrant:~$ exit

vagrant@vagrant:~$ sudo nano /proc/sys/kernel/yama/ptrace_scope - (права редактируем)
vagrant@vagrant:~$ screen -S 1227

screen:
agrant@vagrant:~$ reptyr 1227
ctrl+a и d

Получаем:
[detached from 1261.1227]
vagrant@vagrant:~$ ps -a
    PID TTY          TIME CMD
   1269 pts/1    00:00:00 reptyr
   1270 pts/0    00:00:00 top <defunct>
   1276 pts/0    00:00:00 ps
   
14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.

Команда tee:
Опции команды:
    -a или -append - Используется для записи вывода в конец существующего файла.
     -i или -ignore-interrupts - Используется, чтобы игнорировать прерывающие сигналы.
    -help - Используется для показа всех возможных операций.
    -version - Используется для показа текущей версии этой команды.

Для сохранения вывода команды можно передать один или несколько файлов.
Также tee - принимает данные из одного источника и может сохранять их на выходе в нескольких местах и обладает правами записи в root
