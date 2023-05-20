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


