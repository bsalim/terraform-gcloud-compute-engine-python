variable "credentials" {
  description = "Path to the service account key file"
  type        = string
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "project" {
  description = "The project ID to deploy resources"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

variable "zone" {
  description = "The zone to deploy resources"
  type        = string
  default     = "asia-southeast1-a"
}

variable "machine_type" {
  description = "The machine type to use for the instance"
  type        = string
}

variable "image" {
  description = "The image to use for the instance"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "python_version" {
  description = "Python version"
  default     = "3.12.4"
}

variable "python_source_url" {
  description = "URL to download Python source"
}

variable "mysql_apt_config_url" {
  description = "URL to download the MySQL APT repository configuration package"
  type        = string
}