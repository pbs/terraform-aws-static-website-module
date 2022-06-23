variable "s3_regional_domain_name" {
  description = "(optional) s3 regional domain name."
  default     = null
  type        = string
}

variable "source_policy_documents" {
  description = "(Optional) - List of IAM policy documents that are merged together into the exported document. Statements defined in source_policy_documents or source_json must have unique sids. Statements with the same sid from documents assigned to the override_json and override_policy_documents arguments will override source statements."
  default     = null
  type        = list(string)
}

variable "override_policy_documents" {
  description = "(Optional) - List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid from earlier documents in the list. Statements with non-blank sids will also override statements with the same sid from documents provided in the source_json and source_policy_documents arguments. Non-overriding statements will be added to the exported document."
  default     = null
  type        = list(string)
}
