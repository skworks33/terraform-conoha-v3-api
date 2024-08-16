variable "secgroup_name" {
  description = "The name of the security group"
  type        = string
}

variable "secgroup_description" {
  description = "Description of the security group"
  type        = string
}

variable "rules" {
  description = "List of security group rules"
  type = list(object({
    direction      = string
    ethertype      = string
    protocol       = string
    port_range_min = number
    port_range_max = number
  }))
}
