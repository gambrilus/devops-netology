output "subnet_zone" {
  value = yandex_vpc_subnet.develop[*].zone
}

output "network_id" {
  value = yandex_vpc_network.develop.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.develop[*].id
}