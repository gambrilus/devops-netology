resource "local_file" "hosts_cfg" {
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.db, yandex_compute_instance.storage]
  content = templatefile("${path.module}/hosts.tftpl", {
     webservers =  yandex_compute_instance.web,
     databases =  yandex_compute_instance.db,
     storage =  yandex_compute_instance.storage
     }  )

  filename = "${abspath(path.module)}/hosts.cfg"
}

