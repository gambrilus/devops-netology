Чеклист готовности к домашнему заданию

Скачайте и установите актуальную версию terraform >=1.4.0 . Приложите скриншот вывода команды terraform --version.
    ![изображение](https://github.com/gambrilus/devops-netology/assets/100866321/dc05e5ac-4db1-408d-a8be-b34eef1a09fa)

Скачайте на свой ПК данный git репозиторий. Исходный код для выполнения задания расположен в директории 01/src.
Убедитесь, что в вашей ОС установлен docker.
    

Задание 1

Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.
Изучите файл .gitignore. В каком terraform файле согласно этому .gitignore допустимо сохранить личную, секретную информацию?

      personal.auto.tfvars
      
Выполните код проекта. Найдите в State-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.

      "result": "e9OBweos9QbEMZwu"
      
Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла main.tf. Выполните команду terraform validate. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.

      24 строка - описан только тип ресурса, необходимо дописать имя. Т.к. в 30 строке идет обращение к  docker_image.nginx. - называем nginx
      29 строка - имя может начинаться только с букв. ставим 1 в конец имени
      31 строка - обращение к незаданному ресурсу меняем на "example_${random_password.random_string.result}"
      
Выполните код. В качестве ответа приложите вывод команды docker ps
```   docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
e722ca243351   f9c14fe76d50               "/docker-entrypoint.…"   19 seconds ago   Up 19 seconds   0.0.0.0:8000->80/tcp                        example_e9OBweos9QbEMZwu
```
Замените имя docker-контейнера в блоке кода на hello_world, выполните команду terraform apply -auto-approve. Объясните своими словами, в чем может быть опасность применения ключа -auto-approve ? 
В качестве ответа дополнительно приложите вывод команды docker ps
    
        Опасность в том что у нас декларативный подход - следовательно все что не обьявлено будет уничтожено и в случае "косяка" настройки у нас не будет возможности остановить выполнение.
```    docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
d69d5355425c   f9c14fe76d50               "/docker-entrypoint.…"   10 seconds ago   Up 10 seconds   0.0.0.0:8000->80/tcp                        example_e9OBweos9QbEMZwu
```
    
Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
```
cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.4.6",
  "serial": 22,
  "lineage": "498ff6c9-c9fb-4153-634e-4d1e116604cb",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
Объясните, почему при этом не был удален docker образ nginx:latest ? Ответ подкрепите выдержкой из документации провайдера.

    Возможно у меня что-то пошло не так или я неверно выполнил пункт с заменой hello_world, но у меня удалилось все))


```
terraform destroy
docker_image.nginx: Refreshing state... [id=sha256:f9c14fe76d502861ba0939bc3189e642c02e257f06f4c0214b1f8ca329326cdanginx:latest]
random_password.random_string: Refreshing state... [id=none]
docker_container.hello_world: Refreshing state... [id=1ef77e3c652bf0ad912bc99ecd3804b8d0b2b94b8455019b0c680e1ee1c81e1d]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.hello_world will be destroyed
  - resource "docker_container" "hello_world" {
      - attach                                      = false -> null
      - command                                     = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> null
      - container_read_refresh_timeout_milliseconds = 15000 -> null
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      - entrypoint                                  = [
          - "/docker-entrypoint.sh",
        ] -> null
      - env                                         = [] -> null
      - group_add                                   = [] -> null
      - hostname                                    = "1ef77e3c652b" -> null
      - id                                          = "1ef77e3c652bf0ad912bc99ecd3804b8d0b2b94b8455019b0c680e1ee1c81e1d" -> null
      - image                                       = "sha256:f9c14fe76d502861ba0939bc3189e642c02e257f06f4c0214b1f8ca329326cda" -> null
      - init                                        = false -> null
      - ipc_mode                                    = "private" -> null
      - log_driver                                  = "json-file" -> null
      - log_opts                                    = {} -> null
      - logs                                        = false -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      - must_run                                    = true -> null
      - name                                        = (sensitive value) -> null
      - network_data                                = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.6"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - mac_address               = "02:42:ac:11:00:06"
              - network_name              = "bridge"
            },
        ] -> null
      - network_mode                                = "default" -> null
      - privileged                                  = false -> null
      - publish_all_ports                           = false -> null
      - read_only                                   = false -> null
      - remove_volumes                              = true -> null
      - restart                                     = "no" -> null
      - rm                                          = false -> null
      - runtime                                     = "runc" -> null
      - security_opts                               = [] -> null
      - shm_size                                    = 64 -> null
      - start                                       = true -> null
      - stdin_open                                  = false -> null
      - stop_signal                                 = "SIGQUIT" -> null
      - stop_timeout                                = 0 -> null
      - storage_opts                                = {} -> null
      - sysctls                                     = {} -> null
      - tmpfs                                       = {} -> null
      - tty                                         = false -> null
      - wait                                        = false -> null
      - wait_timeout                                = 60 -> null

      - ports {
          - external = 8000 -> null
          - internal = 80 -> null
          - ip       = "0.0.0.0" -> null
          - protocol = "tcp" -> null
        }
    }

  # docker_image.nginx will be destroyed
  - resource "docker_image" "nginx" {
      - id           = "sha256:f9c14fe76d502861ba0939bc3189e642c02e257f06f4c0214b1f8ca329326cdanginx:latest" -> null
      - image_id     = "sha256:f9c14fe76d502861ba0939bc3189e642c02e257f06f4c0214b1f8ca329326cda" -> null
      - keep_locally = true -> null
      - name         = "nginx:latest" -> null
      - repo_digest  = "nginx@sha256:af296b188c7b7df99ba960ca614439c99cb7cf252ed7bbc23e90cfda59092305" -> null
    }

  # random_password.random_string will be destroyed
  - resource "random_password" "random_string" {
      - bcrypt_hash = (sensitive value) -> null
      - id          = "none" -> null
      - length      = 16 -> null
      - lower       = true -> null
      - min_lower   = 1 -> null
      - min_numeric = 1 -> null
      - min_special = 0 -> null
      - min_upper   = 1 -> null
      - number      = true -> null
      - numeric     = true -> null
      - result      = (sensitive value) -> null
      - special     = false -> null
      - upper       = true -> null
    }

Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

docker_container.hello_world: Destroying... [id=1ef77e3c652bf0ad912bc99ecd3804b8d0b2b94b8455019b0c680e1ee1c81e1d]
docker_container.hello_world: Destruction complete after 0s
docker_image.nginx: Destroying... [id=sha256:f9c14fe76d502861ba0939bc3189e642c02e257f06f4c0214b1f8ca329326cdanginx:latest]
random_password.random_string: Destroying... [id=none]
docker_image.nginx: Destruction complete after 0s
random_password.random_string: Destruction complete after 0s

Destroy complete! Resources: 3 destroyed.
```


Задание 2*
Изучите в документации provider Virtualbox от shekeriev.
Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN советуем выбрать любой образ с расположением в github из списка

```terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # virtualbox_vm.vm1 will be created
  + resource "virtualbox_vm" "vm1" {
      + cpus   = 1
      + id     = (known after apply)
      + image  = "https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box"
      + memory = "512 mib"
      + name   = "centos_7"
      + status = "running"

      + network_adapter {
          + device                 = "IntelPro1000MTDesktop"
          + host_interface         = "vboxnet1"
          + ipv4_address           = (known after apply)
          + ipv4_address_available = (known after apply)
          + mac_address            = (known after apply)
          + status                 = (known after apply)
          + type                   = "hostonly"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + IPAddress = (known after apply)
```

![изображение](https://github.com/gambrilus/devops-netology/assets/100866321/7d6339e1-a363-42f9-b56f-f778326a2df9)


