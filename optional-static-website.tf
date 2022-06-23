variable "name" {
  description = "Name to use for the static site. If null, will default to product."
  default     = null
  type        = string
}

variable "additional_origin_configurations" {
  description = "Additional origin configurations to merge into default configuration. Useful for setting origin shield configurations"
  default     = {}
  type        = any
}
