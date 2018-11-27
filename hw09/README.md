# ДЗ №9. Работа с процессами

## В процессе сделано
- создан `vagrantfile` для проверки и запуска скриптов внутри виртуальной машины.
- Изучены основы работы с процессами signals, fork, procfs
- изучены утилиты для работы с процессами 
  - `ps`, `iotop`, `top`, `nice`, `ionice`
- для ДЗ написаны скрипты
  - демонстрация работы `ionice`
  - демонстрация работы `nice`
  - работа с `procfs` для симуляции утилиты ps
  - добавлены обработчики сигналов в py-скрипт

## Как запустить проект:

 - из папки `hw09` репозитория запустить виртуальную машину командой `vagrant up`
 
## Как проверить работоспособность:

- залогиниться в виртуальную машину командой `vagrant ssh otuslinux`
- запустить скрипт `sudo /vagrant/ionice-demo.sh` .
   
   пример результата работы скрипта (результат получен на HDD):
   ```
   sudo ./ionice-demo.sh 
   time    command
   1:13.40 ionice -c1 -n0 dd if=/dev/zero of=out.4 bs=1024 count=10000 oflag=direct
   1:58.32 ionice -c1 -n7 dd if=/dev/zero of=out.3 bs=1024 count=10000 oflag=direct
   3:04.78 ionice -c2 -n0 dd if=/dev/zero of=out.2 bs=1024 count=10000 oflag=direct
   3:55.77 ionice -c2 -n7 dd if=/dev/zero of=out.1 bs=1024 count=10000 oflag=direct
   4:52.39 ionice -c3 dd if=/dev/zero of=out.0 bs=1024 count=10000 oflag=direct
   ```
- запустить скрипт `sudo /vagrant/nice-demo.sh`.
   
   пример результата работы скрипта:
   ```
   sudo ./nice-demo.sh 
   time    command
   0:59.20 nice -n -20 ./nice-task.sh
   1:33.70 nice -n 0 ./nice-task.sh
   2:01.99 nice -n 19 ./nice-task.sh
   ```

_После проверки можно удалить виртуальную машину командой `vagrant destroy`_
