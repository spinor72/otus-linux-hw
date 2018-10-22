# ДЗ №1 Компиляция ядра Linux

## В процессе сделано
- Установлена вирутальная машина с ОС Centos 7
- Определены пакеты, необходимые для компиляции ядра: 'ncurses-devel make gcc bc openssl-devel bison flex  elfutils-libelf-devel'
- Скомпилировано ядро

## Как запустить проект:
- Установить виртуальную машину  Centos 7 (проверялось на минимальной сетевой установке)
- Из этой папки репозитория перенести на тестовый хост скрипт 'kernel.sh' ,например, командой 'scp kernel.sh root@<адрес машины>:' 
- при необходимости, поменять в скрипте  переменую 'KERNEL_VERSION' с версией собираемого ядра
- залогиниться привилегированным пользователем и сделать скрипт исполняемым 'chmod +x kernel.sh' , запустить его 
- должны установиться нужные пакеты и запуститься процесс сборки ядра и модулей

_если нужно использовать параметры конфигурации ядра, отличные от дефолтных, то необходимо запустить 'make menuconfig' из папки с распакованными из архива исходниками ядра и указать нужные опции._

## Как проверить работоспособность:
 - скрипт должен выполниться без ошибок
 - в папке /boot должно появиться скомпилированное ядро  vmlinuz-<версия> и образ initramfs-<версия>.img
 - при перезагрузке хоста, в списке загрузки ядер должна появиться опция с новым ядром