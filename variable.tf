variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}


variable "jenkins_password" {
  type      = string
  sensitive = true
}


variable "github_user" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

