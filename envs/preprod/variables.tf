variable "env" {
  type = string
}

variable "location" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
