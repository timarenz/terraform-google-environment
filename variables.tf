variable "environment_name" {
  type = string
}

variable "owner_name" {
  type    = string
  default = null
}

variable "ttl" {
  type    = number
  default = 48
}

variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west4"
}

variable "cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "subnets" {
  # type = list
  default = [
    {
      name   = "subnet-1"
      prefix = "192.168.40.0/24"
    },
    {
      name   = "subnet-2"
      prefix = "192.168.41.0/24"
    },
    {
      name   = "subnet-3"
      prefix = "192.168.42.0/24"
    },
  ]
}
