1  В директории /usr/lib/systemd/system/ создаем файл node_exporter.service

В нем прописываем:
[Unit]
Description=Node_exporter

[Service]
EnviromentFile=/etc/node_exporter/node_env
ExecStart=/usr/bin/node_exporter/node_exporter $OPTIONS


[Install]
WantedBy=multi-user.target

UPD.
В файл /etc/node_exporter/node_env добавляем значения переменной $OPTIONS, например $OPTIONS="--collector.cgroups". Теперь при старте служба будет включать данный коллектор, который по умолчанию выключен.
Добавляем стартуем юнит и добавляем его в автозагрузку

sudo systemctl start node_exporter.service
sudo systemctl enable node_exporter.service

2   Метрики для

CPU:
node_cpu_seconds_total
node_pressure_cpu_waiting_seconds_total
node_schedstat_running_seconds_total

Memory:
node_memory_MemAvailable_bytes
node_memory_MemFree_bytes

Disk:
node_disk_io_time_seconds_total{device="sda"}
node_disk_io_time_weighted_seconds_total{device="sda"} 
node_disk_read_bytes_total{device="sda"}
node_disk_read_time_seconds_total{device="sda"} 
node_disk_write_time_seconds_total{device="sda"}
node_disk_writes_completed_total{device="sda"}

Network:
node_network_speed_bytes{device="ens160"}
node_network_receive_bytes_total{device="ens160"}
node_network_transmit_bytes_total{device="ens160"} 

3 ![изображение](https://user-images.githubusercontent.com/100866321/199820747-f74604fa-cd62-4fb3-b522-caa22bc18f61.png)

4  Да, судя по всему понимает что это виртуальная машина
[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] Hypervisor detected: KVM

5   This denotes the maximum number of file-handles a process can allocate. Default value is 1048576
    Его достичь не даст ulimit -n (лимит количества открытых файловых дескрипторов)
    
6   ![изображение](https://user-images.githubusercontent.com/100866321/200040096-908e836b-4991-4d99-8647-062ed1e2a4bc.png)

7   Нагуглилось такое:
:(){ :|:& };:
для понятности заменим : именем f и отформатируем код.
f() {
  f | f &
}
f
таким образом это функция, которая параллельно пускает два своих экземпляра. Каждый пускает ещё по два и т.д. 
При отсутствии лимита на число процессов машина быстро исчерпывает физическую память и уходит в своп.

ulimit -u может решить эту проблему

UPD.
cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope
Процесс останавливается при достижении лимита.
