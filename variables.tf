variable "region" {
  default = "us-east-1"
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  default = "fastfooddb"
}

variable "allowed_ip" {
  description = "IP que pode acessar o banco (ex: sua máquina)"
  default     = "0.0.0.0/0"
}
