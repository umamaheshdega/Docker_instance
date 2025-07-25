variable "environment" {
    default = "prod"
}

variable "common_tags" {
    default = {
        environment = "prod"
        project = "expense"
        terraform = "true"
    }
}

# variable "vpc_id" {
#     default = "vpc-03ae7862e1743e3fc"
# }

variable "vpc_id" {
  description = "VPC where the SG exists"
  type        = string
  default = "vpc-03ae7862e1743e3fc"
}

variable "instances" {
    default = "docker"
    # default = ["mysql","frontend","backend"]

}

# variable "ingress_from_port" {
#     default = 22
# }

# variable "ingress_to_port" {
#     default = 22
# }

variable "cidr_blocks" {
    type    = list(string)
    default = ["0.0.0.0/0"]
}

variable "egress_from_port" {
    default = 0
}

variable "egress_to_port" {
    default = 0
}

variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

# variable "azs_info" {
#   default = {
#     state = "available"
#   }
# }

# variable "default_subnet_cidrs" {
#     default = "allowtls"
# #   default = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]
# }




# variable "default_subnet_tags" {
#     default = {}

# }

variable "project_name" {
    default = "expense"
}




variable "subnet_id" {
  default = "allowtls"  # must belong to the above VPC
}


