1  В директории /usr/lib/systemd/system/ создаем файл node_exporter.service

В нем прописываем:
[Unit]
Description=Node_exporter

[Service]
EnviromentFile=/etc/node_exporter/node_env
ExecStart=/usr/bin/node_exporter/node_exporter


[Install]
WantedBy=multi-user.target

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

3
