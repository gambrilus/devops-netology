1.  https://hub.docker.com/layers/gambrilus/netology/nginx/images/sha256-b48731c42bdb49eceff7d492eae3a48ab3f1be5e2eba377aa1cd07116fbb8fc0?context=repo
2.  Высоконагруженное монолитное java веб-приложение - из-за необходимости получать максимум ресурсов для работы приложения - физический сервер

    Nodejs веб-приложение - для Nodejs удобно использовать контейнеризацию
    
    Мобильное приложение c версиями для Android и iOS - ввиду разных OC я бы использовал виртуальные машины
    
    Шина данных на базе Apache Kafka - на мой взгляд удобно использовать контейнеризацию
    Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - удобно использовать Docker. Например: https://github.com/jeroenhendricksen/elasticsearch-docker-cluster
    
    Мониторинг-стек на базе Prometheus и Grafana - оба приложения достаточно легки и их удобно релизовать контейнеризацией
    
    MongoDB, как основное хранилище данных для java-приложения - для MongoDB можно использовать контейнеризацию или виртуализацию в зависимости от нагруженности базы данных.
    
    Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - обычно для реализации CI\СD процессов используют виртуальный сервер, а так же для храненения образов Docker удобней использовать виртуальный сервер.
    
3.
``` bash
docker run --name centos -v /data:/data -d -it centos

docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
40cb57e1c146   centos    "/bin/bash"   5 seconds ago   Up 4 seconds             centos

docker run --name debian -v /data:/data -d -it debian

docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS              PORTS     NAMES
1eda28fc0219   debian    "bash"        About a minute ago   Up About a minute             debian
40cb57e1c146   centos    "/bin/bash"   About a minute ago   Up About a minute             centos

docker exec -d centos touch /data/file.txt

sudo touch /data/hostfile.txt

docker exec debian ls -a /data
.
..
file.txt
hostfile.txt
```
