variable "location" {
  description = "Localização azure"
  type        = string
  default     = "East US"

}

variable "aws_key_pub" {
  description = "Chave ssh aws"
  type        = string
}

variable "azure_key_pub" {
  description = "Chave ssh azure"
  type        = string
}