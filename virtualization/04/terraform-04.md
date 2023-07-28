##Задание 1

Возьмите из демонстрации к лекции готовый код для создания ВМ с помощью remote-модуля.

Создайте одну ВМ, используя этот модуль. В файле [cloud-init.yml](https://github.com/gambrilus/devops-netology/blob/terraform-04/virtualization/04/src/cloud-init.yml) необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} . Воспользуйтесь примером. Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.

Добавьте в файл [cloud-init.yml](https://github.com/gambrilus/devops-netology/blob/terraform-04/virtualization/04/src/cloud-init.yml) установку nginx.

Предоставьте скриншот подключения к консоли и вывод команды sudo nginx -t.

![04-ter](https://github.com/gambrilus/devops-netology/assets/100866321/8b26af8e-dc5f-4041-9e58-fdf388f86c54)


##Задание 2

Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля, например: ru-central1-a.

Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.

Модуль должен возвращать в виде output информацию о yandex_vpc_subnet.

Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.

Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.

![04-ter-02](https://github.com/gambrilus/devops-netology/assets/100866321/6d5098c4-6d11-4796-b12f-302f8dd80cb0)

Сгенерируйте [документацию](https://github.com/gambrilus/devops-netology/blob/terraform-04/virtualization/04/src/vpc/README.md) к модулю с помощью terraform-docs.

##Задание 3

Список выполненных команд

    - terraform state list
    - terraform state rm 'module.vpc'
    - terraform state rm 'module.test-vm'
    - terraform import 'module.vpc.yandex_vpc_network.develop' 'enpkoi6btmfme8jl6p82'
    - terraform import 'module.vpc.yandex_vpc_subnet.develop' 'e9bafaut4kej7bsigg5f'
    - terraform import 'module.test-vm.yandex_compute_instance.vm[0]' 'fhmga3rgjm7loq6tp1fh'

Приложил список выполненных команд и скриншоты процесса.
    
![04-ter-03-1](https://github.com/gambrilus/devops-netology/assets/100866321/17458410-b56e-405d-b52e-434792ae8954)

![04-ter-03-2](https://github.com/gambrilus/devops-netology/assets/100866321/15cf1397-94d9-430d-a111-4f3c32adc4f6)

##Задание 4

Код в модуле обновлен для выполнения этого задания


```
terraform plan
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=ed5ece6eb8b4d1ca0b8b0075d5dfd4937bc1be12e3b6b86692bb1af67605e2f3]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd85f37uh98ldl1omk30]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.test-vm.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + description               = "TODO: description; {{terraform managed}}"
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "develop-web-0"
      + id                        = (known after apply)
      + labels                    = {
          + "env"     = "develop"
          + "project" = "undefined"
        }
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoOzD86VelsZYpV6eGAkoP6x/cgbzlz0KGX7curl4e+zcjFtFm5YX5I7PGDm/YXJnMciFvwEh1QDw2cG91PiuRa+K8+//dVOzF5l4KjIpmJOx4qD7oAZrVIFlUCRKG9WB1G6vgdQQpv5p6PbY4MiSn9bClLlSwaN8yeqQar/0mJJfIce2fFe+v3gQYUoX1jJD4Sc9X3B/Cw3Qhs35yW3T+GcxqHVHa7MXamXqSwlvsKkHKES6w7KShgTr6iik5oVCSSp3n1wOxgcLXv+4kKH72VgzqllJLy7OdH7gMraPu5YAg7hHuhNa0mP3wr+PiSxXULKtUheBsOakiyvvGx2Vcj7wsyYnaoOPvXUryaZ9py0W0qLI1UnBMyIsjQ3MiqnEElG2mXs/SM/LvkXPVPHrZYxxF5rqIVmUoKkLLzIsJZ5qavdhaSlSBOqFWjZslvO2mwz681lyytxBDt9iGVDi2dX1fIOWHMAOtfhqhD/OYFdlEaF61lhftDZ3D5AIrsME= gambrilus@ubuntu

                package_update: true
                package_upgrade: false
                packages:
                 - vim
                 - nginx
            EOT
        }
      + name                      = "develop-web-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd85f37uh98ldl1omk30"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
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

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.vpc.yandex_vpc_network.develop will be created
  + resource "yandex_vpc_network" "develop" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "develop"
      + subnet_ids                = (known after apply)
    }

  # module.vpc.yandex_vpc_subnet.develop[0] will be created
  + resource "yandex_vpc_subnet" "develop" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-0"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc.yandex_vpc_subnet.develop[1] will be created
  + resource "yandex_vpc_subnet" "develop" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.vpc.yandex_vpc_subnet.develop[2] will be created
  + resource "yandex_vpc_subnet" "develop" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-c"
    }

Plan: 5 to add, 0 to change, 0 to destroy.
╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on .terraform/modules/test-vm/providers.tf line 2, in provider "template":
│    2:   version = "2.2.0"
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that is now deprecated and will be removed in a future version of Terraform. To silence this warning, move the provider version constraint into the required_providers
│ block.
╵
```

![изображение](https://github.com/gambrilus/devops-netology/assets/100866321/bd1b0830-a790-49f8-b90f-a99c33836f52)



