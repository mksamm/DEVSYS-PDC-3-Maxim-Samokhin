1.Установил средство виртуализации Oracle VirtualBox.
2.Установил средство автоматизации Hashicorp Vagrant.
3. Установил Windows Terminal
4. $ cd c:\
$ mkdir vagrant
$ cd vagrant
$ vagrant init
$ nano Vagrantfile
    Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-20.04"
    end
    Выполнил vagrant up, затем vagrant suspend
    5.Cм  во вложении  ![task31](https://user-images.githubusercontent.com/78801043/150679149-f42f9492-83bd-42db-9d71-4561be864cfb.png)
1024 мб оперативная память
2 процессора
6. nano Vagrantfile добавляем следующий блок
    config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 4
end
Затем сохраним изменения и выполним vagrant halt и затем vagrant up
7. Команда vagrant ssh  позволит оказаться внутри виртуальной машины без каких-либо дополнительных настроек.
8. Переменная HISTFILESIZE задаёт длину журнала history, описывается на 621-624 строках 
man bash | grep -n history
man bash | cat -n | sed -n '622,+20p'
   621         HISTFILESIZE
   622                The maximum number of lines contained in the history file.  When this variable is assigned a value, the history file is truncated, if necessary, to contain no more than that number of lines
   623                by removing the oldest entries.  The history file is also truncated to this size after writing it when a shell exits.  If the value is 0, the history file is truncated to zero  size.   Non-
   624                numeric values and numeric values less than zero inhibit truncation.  The shell sets the default value to the value of HISTSIZE after reading any startup files.
Значение ignoreboth является сокращением для ignorespace и ignoredups.
9. man bash | grep -n {
....
man bash | cat -n | sed -n '200,+40p'
}
   206         { list; }
   207                list  is  simply executed in the current shell environment.  list must be terminated with a newline or semicolon.  This is known as a group command.  The return status is the exit status of
   208                list.  Note that unlike the metacharacters ( and ), { and } are reserved words and must occur where a reserved word is permitted to be recognized.  Since they do not  cause  a  word  break,
   209                they must be separated from list by whitespace or another shell metacharacter.
   210
   10. touch {1..100000}
   На 300000 получил ошибку: Argument list too long. Ответ: ограничение на максимальное количество аргументов в команде.
   11.Что делает конструкция [[ -d /tmp ]] Ответ: Конструкция [[ -d /tmp ]] возвращает 1, если выражение в скобках верное, 0 — если не верное.
   12.mkdir /tmp/new_path_directory
cp /bin/bash /tmp/new_path_directory/bash
export PATH="/tmp/new_path_directory:$PATH"  
vagrant@vagrant:~$ type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
13.at запускает команду в назначенное время.
batch запускает команду при достижении определённого уровня нагрузки системы
14.sudo shutdown -h now
