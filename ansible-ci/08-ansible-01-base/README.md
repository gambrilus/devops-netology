1. 12
2. файл all/examp.yml
4.
```
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}
```
6.
```
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
```
9. 
```
ansible-doc -t connection -l
```
Сменил на плагин local

10-11 Выполнено

12. Запушено в репозиторий. 
