variable "environment_name" {
  type = string
}

variable "project" {
  description = "Id of an existing project."
  type        = string
}

# variable "use_existing_project" {
#   description = "If enabled, specify the project of the existing project in the name variable."
#   type        = bool
#   default     = false
# }

variable "region" {
  type    = string
  default = "europe-west4"
}

# variable "org_id" {
#   type    = string
#   default = null
# }

# variable "billing_account" {
#   type    = string
#   default = null
# }

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

variable "disable_crm_api_on_destroy" {
  type    = bool
  default = false
}
