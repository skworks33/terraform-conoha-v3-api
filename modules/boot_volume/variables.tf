variable "boot_volume_name" {
  description = "The name of the boot volume"
  type        = string
}

variable "size" {
  description = "The size of the boot volume in GB"
  type        = number
}

variable "image_id" {
  description = "The ID of the image to use for the boot volume"
  type        = string
}

variable "volume_type" {
  description = "The type of the volume"
  type        = string
}
