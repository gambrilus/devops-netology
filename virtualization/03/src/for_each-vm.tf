resource "yandex_compute_instance" "db" {
for_each = {
"main" = { cores = 4, memory = 2, core_fraction = 20, size = 10 }
 
"replica" = { cores = 2, memory = 1, core_fraction = 5, size = 5 }

}
name = each.key
  resources {
    cores  = each.value.cores
    memory = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = each.value.size
    }   
  }
  scheduling_policy { preemptible = true }

  metadata = {
    ssh-keys           = file("~/.ssh/id_rsa.pub")
  }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  depends_on = [resource.yandex_compute_instance.web]
}

