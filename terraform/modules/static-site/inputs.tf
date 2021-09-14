variable "domain_name" {
  description = "This is the name of the domain you wish to use for this static site"
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
