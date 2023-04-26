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
