1.
```bash
version: '3.5'
services:
  postgres:
    image: postgres:latest
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/data/backup/postgres
    ports:
      - "5432:5432"

docker compose ps
NAME                      IMAGE               COMMAND                  SERVICE             CREATED             STATUS              PORTS
06-db-02-sql-postgres-1   postgres:latest     "docker-entrypoint.s…"   postgres            8 minutes ago       Up 8 seconds        0.0.0.0:5432->5432/tcp, :::5432->5432/tcp
```


2.
```
postgres=# \l
                                                List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+------------+------------+------------+-----------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 test-db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
(4 rows)
****
```

```
test-db=# \d+ orders
                                                                Table "public.orders"
          Column          |  Type   | Collation | Nullable |              Default               | Storage  | Compression | Stats target | Description
--------------------------+---------+-----------+----------+------------------------------------+----------+-------------+--------------+-------------
 id                       | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |             |              |
 наименование             | text    |           |          |                                    | extended |             |              |
 цена                     | integer |           |          |                                    | plain    |             |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test-db=# \d+ clients
                                                                     Table "public.clients"
              Column               |  Type   | Collation | Nullable |               Default               | Storage  | Compression | Stats target | Description
-----------------------------------+---------+-----------+----------+-------------------------------------+----------+-------------+--------------+-------------
 id                                | integer |           | not null | nextval('clients_id_seq'::regclass) | plain    |             |              |
 фамилия                           | text    |           |          |                                     | extended |             |              |
 страна проживания                 | text    |           |          |                                     | extended |             |              |
 заказ                             | integer |           |          |                                     | plain    |             |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
```

```
SELECT table_name, array_agg(privilege_type), grantee
FROM information_schema.table_privileges
WHERE table_name = 'orders' OR table_name = 'clients';
GROUP BY table_name, grantee;
```

```
 table_name |                         array_agg                         |     grantee
------------+-----------------------------------------------------------+------------------
 clients    | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | postgres
 clients    | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | test-admin-user
 clients    | {DELETE,INSERT,SELECT,UPDATE}                             | test-simple-user
 orders     | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | postgres
 orders     | {INSERT,TRIGGER,REFERENCES,TRUNCATE,DELETE,UPDATE,SELECT} | test-admin-user
 orders     | {DELETE,SELECT,UPDATE,INSERT}                             | test-simple-user
(6 rows)
```

3.

```
test-db=# INSERT INTO orders (наименование, цена )
VALUES
    ('Шоколад', '10'),
    ('Принтер', '3000'),
    ('Книга', '500'),
    ('Монитор', '7000'),
    ('Гитара', '4000')
;
INSERT 0 5
```
```
test-db=# INSERT INTO clients ("фамилия", "страна проживания")
VALUES
    ('Иванов Иван Иванович', 'USA'),
    ('Петров Петр Петрович', 'Canada'),
    ('Иоганн Себастьян Бах', 'Japan'),
    ('Ронни Джеймс Дио', 'Russia'),
    ('Ritchie Blackmore', 'Russia')
;
INSERT 0 5
```
```
test-db=# SELECT COUNT(*) FROM orders;
 count
-------
     5
(1 row)

test-db=# SELECT COUNT(*) FROM clients;
 count
-------
     5
(1 row)
```

4.

```
test-db=# UPDATE clients SET "заказ"=3 WHERE id=1;
UPDATE clients SET "заказ"=4 WHERE id=2;
UPDATE clients SET "заказ"=5 WHERE id=3;
UPDATE 1
UPDATE 1
UPDATE 1
```
```
test-db=# SELECT фамилия FROM clients WHERE заказ IS NOT NULL ORDER BY id;
             фамилия
----------------------------------------
 Иванов Иван Иванович
 Петров Петр Петрович
 Иоганн Себастьян Бах
(3 rows)
```

5.
```
test-db=# EXPLAIN SELECT фамилия FROM clients WHERE заказ IS NOT NULL ORDER BY id;
                           QUERY PLAN
-----------------------------------------------------------------
 Sort  (cost=57.01..59.02 rows=806 width=36)
   Sort Key: id
   ->  Seq Scan on clients  (cost=0.00..18.10 rows=806 width=36)
         Filter: ("заказ" IS NOT NULL)
(4 rows)
```

6.
Делаем дамп
```
postgres@1d8ceac089ac:~$ pg_dumpall > /data/backup/postgres/test-db.tar
```
Останавливаем компоуз и удаляем контейнер
```
docker ps -a
CONTAINER ID   IMAGE             COMMAND                  CREATED        STATUS                    PORTS     NAMES
262a71a955c9   postgres:latest   "docker-entrypoint.s…"   2 hours ago    Exited (0) 2 hours ago              postgres-sql-postgres-1

docker rm 262a71a955c9
262a71a955c9
```
Поднимаем новый
```
postgres=# \l
                                                List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+------------+------------+------------+-----------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
(3 rows)

postgres=# \q
postgres@2a85758d63cc:~$ psql -f /data/backup/postgres/test-db.tar postgres
SET
SET
SET
psql:/data/backup/postgres/test-db.tar:14: ERROR:  role "postgres" already exists
ALTER ROLE
CREATE ROLE
ALTER ROLE
CREATE ROLE
ALTER ROLE
You are now connected to database "template1" as user "postgres".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
You are now connected to database "postgres" as user "postgres".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 0
COPY 0
 setval
--------
      1
(1 row)

 setval
--------
      1
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
GRANT
GRANT
GRANT
GRANT
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
CREATE DATABASE
ALTER DATABASE
You are now connected to database "test-db" as user "postgres".
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval
--------
      5
(1 row)

 setval
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
GRANT
GRANT
GRANT
GRANT

postgres@2a85758d63cc:~$ psql
psql (15.2 (Debian 15.2-1.pgdg110+1))
Type "help" for help.

postgres=# \l
                                                List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
-----------+----------+----------+------------+------------+------------+-----------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
           |          |          |            |            |            |                 | postgres=CTc/postgres
 test-db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
(4 rows)
```

