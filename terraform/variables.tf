variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_url" {
  description = "Full Database Connection String"
  type        = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "access_token_expires" {
  type    = number
  default = 60
}

variable "groq_api_key" {
  type      = string
  sensitive = true
}

variable "jwt_key" {
  type      = string
  sensitive = true
}

variable "mail_username" {
  type = string
}

variable "mail_password" {
  type      = string
  sensitive = true
}

variable "mail_from" {
  type = string
}

variable "mail_server" {
  type = string
}

variable "mail_port" {
  type = string
}
