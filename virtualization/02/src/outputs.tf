output "external_ip" {
  value       = {platform = yandex_compute_instance.platform.network_interface.0.nat_ip_address, db = yandex_compute_instance.db.network_interface.0.nat_ip_address}
  description = "instance_name = external_ip"
}
