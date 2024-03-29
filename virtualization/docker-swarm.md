Задача 1

Дайте письменые ответы на следующие вопросы:

    1.В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?

        Global создает в обязательном порядке 1 реплику на каждой ноде. Соотвественно 6 нод - 6 реплик
        Replication создает необходимое количество реплик и создает новые только при падении старых. Например 3 реплики на 6 нодах, означает что на 3 нодах реплик не будет.
    
    2.Какой алгоритм выбора лидера используется в Docker Swarm кластере?
    
        Docker Swarm использует алгоритм Raft для определения лидера. 
    
    3.Что такое Overlay Network?
    
        Драйвер оверлейной сети создает распределенную сеть между несколькими узлами демона Docker. 
        Эта сеть находится поверх (перекрывает) сети, специфичные для хоста, позволяя контейнерам, подключенным к ней (включая контейнеры службы swarm), безопасно обмениваться данными при включенном шифровании. 
        Docker прозрачно обрабатывает маршрутизацию каждого пакета от и к правильному хосту демона Docker и правильному контейнеру назначения.

Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```

docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
kcp3yiutg5kxjejzastqze736 *   node01.netology.yc   Ready     Active         Leader           23.0.1
vqm0l02ozo2dc0tkak75h7ky1     node02.netology.yc   Ready     Active         Reachable        23.0.1
ko77e0zh7d6k93bo1nxe9xu19     node03.netology.yc   Ready     Active         Reachable        23.0.1
riazzt0fp1ic6otp1tgp3o4gb     node04.netology.yc   Ready     Active                          23.0.1
ftrooubayoyb1n90lrgii1da7     node05.netology.yc   Ready     Active                          23.0.1
e2pt6gsosfvuvrwzws0wwboof     node06.netology.yc   Ready     Active                          23.0.1

```
Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
2f0868qelwdl   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
vaagbg79h27w   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
mavatxo3plj4   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest
pmdkj1au3s7l   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
0e94ckdd582n   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
s2zzh1lybhwc   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
4j5112mdsbrt   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
zv0j3j61c65z   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
```



