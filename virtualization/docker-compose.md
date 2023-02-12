1. ![изображение](https://user-images.githubusercontent.com/100866321/218264443-276fd64a-492f-4888-aec9-8559e03446a7.png)
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
              + image_id    = "fd8s746la2g43rauocgs"
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
yandex_vpc_network.default: Creation complete after 1s [id=enpebbt0ficnfanf4rr6]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 0s [id=e2llr74tjdelh2047p91]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Still creating... [50s elapsed]
yandex_compute_instance.node01: Creation complete after 57s [id=epdokilmp9a3b4459jub]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "158.160.19.119"
internal_ip_address_node01_yandex_cloud = "192.168.101.25"
```
![изображение](https://user-images.githubusercontent.com/100866321/218266614-de5497b6-808d-4770-b4a3-1e5b80fff45d.png)

3. Все контейнеры поднялись кроме Caddy который валится с ошибкой 
```
goroutine 1 [running]:
github.com/mholt/caddy/vendor/github.com/miekg/dns.ClientConfigFromFile(0xbb4739, 0x10, 0x0, 0x0, 0x0)
        src/github.com/mholt/caddy/vendor/github.com/miekg/dns/clientconfig.go:86 +0xad6
github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme.getNameservers(0xbb4739, 0x10, 0xfeaf20, 0x2, 0x2, 0xf77460, 0xc4200462c0, 0xc42003df50)
        src/github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme/dns_challenge.go:40 +0x4d
github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme.init()
        src/github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme/dns_challenge.go:33 +0x12d
github.com/mholt/caddy/caddy/caddymain.init()
        <autogenerated>:1 +0x75
main.init()
        <autogenerated>:1 +0x44
panic: runtime error: slice bounds out of range
```

``` bash
docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED         STATUS                         PORTS      NAMES
f4b5b294f2b6   grafana/grafana:7.4.2              "/run.sh"                4 minutes ago   Up 3 minutes                   3000/tcp   grafana
3886845cdd0c   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   4 minutes ago   Up 3 minutes (healthy)         8080/tcp   cadvisor
3803a5755e5b   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   4 minutes ago   Up 3 minutes                   9100/tcp   nodeexporter
e0326212a9ac   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   4 minutes ago   Up 3 minutes                   9090/tcp   prometheus
154a64c252c6   prom/pushgateway:v1.2.0            "/bin/pushgateway"       4 minutes ago   Up 3 minutes                   9091/tcp   pushgateway
f36867059d21   stefanprodan/caddy                 "/sbin/tini -- caddy…"   4 minutes ago   Restarting (2) 8 seconds ago              caddy
f3982fa12279   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   4 minutes ago   Up 3 minutes                   9093/tcp   alertmanager
```

4. Из-за ошибки в Caddy невозможно выполнить задание
