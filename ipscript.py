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


