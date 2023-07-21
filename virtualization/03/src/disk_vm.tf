resource "yandex_compute_disk" "disk" {
  count      = 3
  name       = "disk-${count.index+1}"
  type       = "network-hdd"
  size       = 1
}


resource "yandex_compute_instance" "storage" {
  count = 1
  name = "storage-${count.index+1}"
    resources {
      cores  = 2
      memory = 1
      core_fraction = 20
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
        type = "network-hdd"
        size = 5
      }   
    }
    dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
        disk_id = yandex_compute_disk.disk[secondary_disk.key].id
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
