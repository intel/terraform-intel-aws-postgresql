variable "instance_type" {
  type    = string
  default = "db.m5.2xlarge"
}
variable "username" {
  type    = string
  default = "postgres"
}
variable "password" {
  type    = string
  default = "password#123"
}
variable "storage_type" {
  type    = string
  default = "io1"
}
variable "storage_gb" {
  type    = number
  default = 1024
}
variable "storage_iops" {
  type    = number
  default = 32000
}
