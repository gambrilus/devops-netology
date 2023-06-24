variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "vm_web_name" {
  type        = string
  default     = "develop-platform-web"
  description = "vm name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform_id"
}

variable "vm_web_scheduling_policy" {
  type        = bool
  default     = true
  description = "scheduling_policy"
}

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image db family"
}

variable "vm_db_name" {
  type        = string
  default     = "develop-platform-db"
  description = "vm db name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "db platform_id"
}

variable "vm_db_scheduling_policy" {
  type        = bool
  default     = true
  description = "scheduling_policy"
}

variable "vm_web_resources" {
  default     = {cores = 2, memory = 1, core_fraction = 5}
  description = "vm_web_resources"
}

variable "vm_db_resources" {
  default     = {cores = 2, memory = 2, core_fraction = 20}
  description = "vm_db_resources"
}

variable "metadata" {
  default     = {serial-port-enable = 1, ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9+LfjcwR4DnvH0gyYKIjyynHUFjZSBbNt7PzKRlbW1 gambrilus@ubuntu"}
  description = "metadata"
}