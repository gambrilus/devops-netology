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
