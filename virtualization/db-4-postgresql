1.

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \c postgres
Password:
You are now connected to database "postgres" as user "postgres".

postgres=# \dt
Did not find any relations.
postgres=# \dt+
Did not find any relations.
postgres=# \d pg_database
               Table "pg_catalog.pg_database"
    Column     |   Type    | Collation | Nullable | Default
---------------+-----------+-----------+----------+---------
 oid           | oid       |           | not null |
 datname       | name      |           | not null |
 datdba        | oid       |           | not null |
 encoding      | integer   |           | not null |
 datcollate    | name      |           | not null |
 datctype      | name      |           | not null |
 datistemplate | boolean   |           | not null |
 datallowconn  | boolean   |           | not null |
 datconnlimit  | integer   |           | not null |
 datlastsysoid | oid       |           | not null |
 datfrozenxid  | xid       |           | not null |
 datminmxid    | xid       |           | not null |
 dattablespace | oid       |           | not null |
 datacl        | aclitem[] |           |          |
Indexes:
    "pg_database_datname_index" UNIQUE, btree (datname), tablespace "pg_global"
    "pg_database_oid_index" UNIQUE, btree (oid), tablespace "pg_global"
Tablespace: "pg_global"

postgres=# \q
```
2.

```
test_database=# SELECT tablename, attname, avg_width FROM pg_stats WHERE avg_width IN (SELECT MAX(avg_width) FROM pg_stats WHERE tablename = 'orders') and tablename = 'orders';
 tablename | attname | avg_width 
-----------+---------+-----------
 orders    | title   |        16
 ``

3. 
```
BEGIN;
ALTER TABLE orders RENAME TO orders_old;

CREATE TABLE orders AS table orders_old WITH NO DATA;

CREATE TABLE orders_high (
    CHECK (price > 499)
) INHERITS (orders);

CREATE TABLE orders_low (
    CHECK (price <= 499)
) INHERITS (orders);

CREATE RULE orders_high_insert AS
ON INSERT TO orders WHERE
    (price > 499)
DO INSTEAD
    INSERT INTO orders_high VALUES (NEW.*);
       
CREATE RULE orders_low_insert AS
ON INSERT TO orders WHERE
    (price <= 499)
DO INSTEAD
    INSERT INTO orders_low VALUES (NEW.*);
    
INSERT INTO orders
SELECT * FROM orders_old;
COMMIT;
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
Да, используя параметр PARTITION BY RANGE с последующим созданием новых таблиц
```
CREATE TABLE orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
) PARTITION BY RANGE (price);

CREATE TABLE orders_high PARTITION OF orders
    FOR VALUES GREATER THAN ('499');

CREATE TABLE orders_low PARTITION OF orders
    FOR VALUES FROM ('0') TO ('499');
```


4.
```
root@d9fad5ed1b40:/# pg_dump -U postgres -v -f /var/lib/postgresql/data/test_database.sql
```

Для уникальности следует добавить к столбцу ограничение UNIQUE
