Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"
Цель задания

В результате выполнения этого задания вы:

    Познакомитесь с синтаксисами JSON и YAML.
    Узнаете как преобразовать один формат в другой при помощи пары строк.

Чеклист готовности к домашнему заданию

Установлена библиотека pyyaml для Python 3.
Инструкция к заданию

    Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть здесь.
    Заполните недостающие части документа решением задач (заменяйте ???, остальное в шаблоне не меняйте, чтобы не сломать форматирование текста, подсветку синтаксиса и прочее) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желанию.
    Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.

Задание 1
Обязательная задача 1

Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
Нужно найти и исправить все ошибки, которые допускает наш сервис

Ваш скрипт:

Не хватает кавычек в строках с IP 
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : "7175" 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
Задание 2

В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.
Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time
import yaml
import json

#Fill files
dnsnames = ['drive.google.com', 'mail.google.com', 'google.com', 'yandex.ru']
i = 0
hostIP = {}
for host in dnsnames:
  hostIP[host] = socket.gethostbyname(host)
print(hostIP)
with open ('hostsIP.json', 'w') as js:
  js.write(json.dumps(hostIP, indent=2))
with open ('hostsIP.yaml', 'w') as ym:
  ym.write(yaml.dump(hostIP))


#Check changes & rewrite files
while i in range(30):
  for host in dnsnames:
    if hostIP[host] != socket.gethostbyname(host):
      print('[ERROR] ' + host + ' IP mismatch: ' + hostIP[host] + ' ' + socket.gethostbyname(host))
      hostIP[host] = socket.gethostbyname(host)
      with open ('hostsIP.json', 'w') as js:
        js.write(json.dumps(hostIP, indent=2))
      with open ('hostsIP.yaml', 'w') as ym:
        ym.write(yaml.dump(hostIP))
  i += 1
  time.sleep(0.5)
```
Вывод скрипта при запуске при тестировании:
```
python3 ipscript.py
{'drive.google.com': '64.233.165.194', 'mail.google.com': '108.177.14.19', 'google.com': '216.58.209.174', 'yandex.ru': '5.255.255.50'}
[ERROR] yandex.ru IP mismatch: 5.255.255.50 5.255.255.55
[ERROR] yandex.ru IP mismatch: 5.255.255.55 77.88.55.66
[ERROR] yandex.ru IP mismatch: 5.255.255.55 77.88.55.66
[ERROR] drive.google.com IP mismatch: 64.233.165.194 64.233.164.194
[ERROR] mail.google.com IP mismatch: 108.177.14.19 108.177.14.17
[ERROR] mail.google.com IP mismatch: 108.177.14.18 209.85.233.19
```
json-файл(ы), который(е) записал ваш скрипт:
```
cat hostsIP.json

{
  "drive.google.com": "64.233.164.194",
  "mail.google.com": "209.85.233.19",
  "google.com": "216.58.209.174",
  "yandex.ru": "77.88.55.66"
}                                                                                                                                                                                                                                                                                     
```
yml-файл(ы), который(е) записал ваш скрипт:
```
cat hostsIP.yaml

drive.google.com: 64.233.164.194
google.com: 216.58.209.174
mail.google.com: 209.85.233.19
yandex.ru: 77.88.55.66

```

Правила приема домашнего задания

В личном кабинете отправлена ссылка на .md файл в вашем репозитории.
Критерии оценки

Зачет - выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки.

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке. Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.
