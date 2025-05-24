variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    Terraform = "true"
    Component = "ingress-alb"
  }
}

variable "zone_name" {
  default = "prasadbeedam.shop"
}

variable "zone_id" {
  default = "Z09605221F3CC18W1YD8H"
}