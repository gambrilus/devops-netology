1.
Dockerfile
```
FROM centos:7
COPY elasticsearch-8.7.1-linux-x86_64.tar.gz  /opt
RUN cd /opt &&\
    groupadd elasticgroup &&\
    useradd -c "elastic" -g elasticgroup elastic &&\
    tar -xzf elasticsearch-8.7.1-linux-x86_64.tar.gz &&\
    chmod -R 777 /var/lib/ &&\
    chown -R elastic:elasticgroup /opt/elasticsearch-8.7.1
USER elastic
WORKDIR /opt/elasticsearch-8.7.1/
COPY elasticsearch.yml  config/
EXPOSE 9200 9300
ENTRYPOINT ["bin/elasticsearch"]
```
[Образ](https://hub.docker.com/layers/gambrilus/netology/elastic)

```
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "EFphTX6uRPqiueIQ7ADslA",
  "version" : {
    "number" : "8.7.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "f229ed3f893a515d590d0f39b05f68913e2d9b53",
    "build_date" : "2023-04-27T04:33:42.127815583Z",
    "build_snapshot" : false,
    "lucene_version" : "9.5.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
2.

```
curl -X GET "localhost:9200/_cat/indices"
green  open ind-1 R8WBl9JcRVOl-9nbu5LmAQ 1 0 0 0 225b 225b
yellow open ind-3 8tS0TVtRQbGRjjj2Sux-lg 4 2 0 0 900b 900b
yellow open ind-2 Lc-J8I0eTKaD5W2RVR8Epw 2 1 0 0 450b 450b
```

```
curl -X GET localhost:9200/_cluster/health
{
              "cluster_name":"elasticsearch",
              "status":"yellow",
              "timed_out":false,
              "number_of_nodes":1,
              "number_of_data_nodes":1,
              "active_primary_shards":7,
              "active_shards":7,
              "relocating_shards":0,
              "initializing_shards":0,
              "unassigned_shards":10,
              "delayed_unassigned_shards":0,
              "number_of_pending_tasks":0,
              "number_of_in_flight_fetch":0,
              "task_max_waiting_in_queue_millis":0,
              "active_shards_percent_as_number":41.17647058823529
}
```

Индексы и кластер находятся в yellow, потому что мы указали количество реплик больше 1, но в кластере у нас только 1 нода, поэтому реплицировать индексы некуда.

3.
```
curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
> {
>   "type": "fs",
>   "settings": {
>     "location": "/opt/elasticsearch-8.7.1/snapshots"
>   }
> }
> '
{
  "acknowledged" : true
}
```

```
ls -la
total 48
drwxr-xr-x 3 elastic elasticgroup  4096 May 20 20:09 .
drwxr-xr-x 1 elastic elasticgroup  4096 May 20 20:04 ..
-rw-r--r-- 1 elastic elasticgroup   592 May 20 20:09 index-0
-rw-r--r-- 1 elastic elasticgroup     8 May 20 20:09 index.latest
drwxr-xr-x 3 elastic elasticgroup  4096 May 20 20:09 indices
-rw-r--r-- 1 elastic elasticgroup 18802 May 20 20:09 meta-Ol20UuxITRaHC7q3GH6tHw.dat
-rw-r--r-- 1 elastic elasticgroup   312 May 20 20:09 snap-Ol20UuxITRaHC7q3GH6tHw.dat
```

```
curl -X GET "localhost:9200/_cat/indices"
green open test-2 f6m6d1hiRU-cxUM1h7FNtw 1 0 0 0 225b 225b
```

```
curl -X POST "localhost:9200/_snapshot/netology_backup/netology_backup1/_restore?pretty" -H 'Content-Type: application/json' -d'
> {
>   "indices": "test"
> }
> '
{
  "accepted" : true
}
```


