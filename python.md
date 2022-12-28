Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"


Задание 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```
```
Вопросы:
Вопрос 	                                        Ответ
Какое значение будет присвоено переменной c? 	никакое, потому что нельзя складывать int и str
Как получить для переменной c значение 12? 	c = str(a) + b
Как получить для переменной c значение 3? 	c = a + int(b)
```
Задание 2

Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся.

Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```
Ваш скрипт:
Не ясно для чего переменная is_change, которая нигде не используется и оператор break который останавливает выполнение итерации после первого же найденного файла
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/devops-netology/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
```

Вывод скрипта при запуске при тестировании:

Внес изменения в файл bash.md

```bash
gambrilus@ubuntu  ~/devops-netology/devops-netology   main ✚  python3 scriptpy.py
bash.md

```

Задание 3

Доработать скрипт выше так, чтобы он не только мог проверять локальный репозиторий в текущей директории, но и умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.
Ваш скрипт:

???

Вывод скрипта при запуске при тестировании:

???

Задание 4

Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис.

Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков.

Мы хотим написать скрипт, который:

    опрашивает веб-сервисы,
    получает их IP,
    выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>.

Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.
Ваш скрипт:
```python
#!/usr/bin/env python3
import socket
import time

dnsnames = ['drive.google.com', 'mail.google.com', 'google.com', 'yandex.ru']
i = 0
hostIP = {}
for host in dnsnames:
  hostIP[host] = socket.gethostbyname(host)
print(hostIP)

while i in range(120):
  for host in dnsnames:
    if hostIP[host] != socket.gethostbyname(host):
      print('[ERROR] ' + host + ' IP mismatch: ' + hostIP[host] + ' ' + socket.gethostbyname(host))
      hostIP[host] = socket.gethostbyname(host)
  i += 1
  time.sleep(0.5)
```

Вывод скрипта при запуске при тестировании:

```
gambrilus@ubuntu  ~/devops-netology/devops-netology   main ✚  python3 ipscript.py
{'drive.google.com': '142.251.1.194', 'mail.google.com': '216.58.209.197', 'google.com': '216.58.209.174', 'yandex.ru': '5.255.255.70'}
[ERROR] google.com IP mismatch: 216.58.209.174 216.58.209.206
```

