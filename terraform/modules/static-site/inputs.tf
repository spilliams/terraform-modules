variable "domain_name" {
  description = "This is the name of the domain you wish to use for this static site"
  type        = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "extra_aliases" {
  description = "(Optional) These are the extra aliases you wish to apply to the cloudfront"
  type        = list(string)
  default     = []
}

variable "extra_allowed_origins" {
  description = "(Optional) These are the allowed origins on the S3 bucket (CORS rules)"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "(Optional) This is for users who want to create their own hosted zone. Note that this module will create an A record on the hosted zone"
  type        = string
  default     = ""
}
