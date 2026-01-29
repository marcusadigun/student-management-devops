variable "aws_region" {
  default = "us-east-1"
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "groq_api_key" {
  description = "Groq API Key"
  type        = string
  sensitive   = true
}

variable "jwt_key" {
  description = "JWT Key"
  type        = string
  sensitive   = true
}
