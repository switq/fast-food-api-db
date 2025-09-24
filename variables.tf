variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/16"] # exemplo: VPC privada onde está o EKS
}

variable "db_name" {
  type    = string
  default = "lanchonete"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type      = string
  sensitive = true
}
