# data "aws_vpc" "default" {
#     default = true


# }

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = var.vpc_id
}

# data "aws_subnets" "default" {
#     filter {
#        name   = "vpc-id"
#        values = [var.vpc_id]
#     }
# }

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "selected" {
  id = data.aws_subnets.selected.ids[0]
}