1. ![изображение](https://user-images.githubusercontent.com/100866321/218335913-64fb0170-d7b0-48b8-9d93-bffedbc14d42.png)

2. 
``` bash
terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: gambrilus
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCg93e4uKuoRNiHl5H6XoM01nGt52cBlbvgRXMkf2XDbZzElSybsWC7+p3eO1tbd1r/IzwooLhaPadZboTEJ4jwnEd5lqoX/WWW5+y9O5vlxKCXEhEfR0fs5OHnrk7nafzZT/bRDHAicHC8Q+XF+cRbgNFTw095mBUChyLLEqZvcSTwAePHroWlDFL6auj7Ywz7oL1VuUC5MO37HqL0KuJwqTNDIqsR7fCnNq5N89yKgHMBkOICDjuiA3YvnqQBjE9J2qd/S1mKpRRscHvGFctdfGr2ypbkW0F0geR3kh5voY6000sMSDtaoRqnkcRAlPlKRozQMbK7SnY+bfQuUrXp gambrilus@DESKTOP-7C8AGBU

            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd823j04gp6q1hjie6un"
              + name        = "root-node01"
              + size        = 50
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 8
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_node01_yandex_cloud = (known after apply)
  + internal_ip_address_node01_yandex_cloud = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.default: Creation complete after 1s [id=enpe0iut6djjql2j0kaa]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 1s [id=e2l7c8jpvndl90ssljam]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Still creating... [50s elapsed]
yandex_compute_instance.node01: Creation complete after 51s [id=epd70qkh3b3lefuhes7f]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "51.250.28.233"
internal_ip_address_node01_yandex_cloud = "192.168.101.23"

```
![изображение](https://user-images.githubusercontent.com/100866321/218336277-3673410a-7466-4eb4-839d-644f70d0a966.png)


3. 
``` bash
docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                             PORTS                                                                              NAMES
f5f2b1d9c392   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   37 seconds ago   Up 14 seconds                      9100/tcp                                                                           nodeexporter
c8206eb3213c   prom/pushgateway:v1.2.0            "/bin/pushgateway"       37 seconds ago   Up 14 seconds                      9091/tcp                                                                           pushgateway
7fec7f6f58ee   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   37 seconds ago   Up 14 seconds                      9090/tcp                                                                           prometheus
9dc1c3f9df1b   stefanprodan/caddy                 "/sbin/tini -- caddy…"   37 seconds ago   Up 14 seconds                      0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy
36d18714cc13   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   37 seconds ago   Up 14 seconds (health: starting)   8080/tcp                                                                           cadvisor
4bfc37528aec   grafana/grafana:7.4.2              "/run.sh"                37 seconds ago   Up 15 seconds                      3000/tcp                                                                           grafana
f68ff349b78c   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   37 seconds ago   Up 14 seconds                      9093/tcp                                                                           alertmanager

```

4. 
![изображение](https://user-images.githubusercontent.com/100866321/218339775-12c38ec2-c768-4b9b-b67b-05311305b158.png)
