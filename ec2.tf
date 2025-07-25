resource "aws_instance" "terraform_demo" {
  # count = length(var.instances)
  ami = var.environment== "prod"? "ami-09c813fb71547fc4f" : "ami-07041441b708acbd6"
  # subnet_id =  aws_subnet.default[count.index % length(aws_subnet.default)].id
  subnet_id = data.aws_subnet.selected.id
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_security_group.default.id]
  instance_type = var.environment =="prod"? "t2.micro" : "t2.medium"
  root_block_device {
  volume_size = 50                # <-- 50 GB root volume
  volume_type = "gp3"
  delete_on_termination = true
  }

  user_data              = file("userdata.sh")
  tags = merge (
    var.common_tags,
    
    {
      Name =  var.instances
    }


  )
    
}

# resource "aws_subnet" "default" {
#     count = length(var.default_subnet_cidrs)
#     vpc_id     = aws_vpc.custom.id
#     cidr_block = var.default_subnet_cidrs[count.index]
#     availability_zone = local.az_names[count.index]
#     map_public_ip_on_launch = true

#   tags = merge(
#     var.common_tags,
#     var.default_subnet_tags,
#     {
#         Name = "${var.project_name}-${var.environment}-default-${local.az_names[count.index]}"
#     }

#   )
# }

# resource "aws_vpc" "custom" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "${var.project_name}-${var.environment}-vpc"
#   }
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "${var.project_name}-${var.environment}-sg"
#   description = "Allow SSH and HTTP"
#   vpc_id      = aws_vpc.custom.id

#   ingress {
#     from_port = var.ingress_from_port
#     to_port = var.ingress_to_port
#     cidr_blocks = var.cidr_blocks
#     protocol = "tcp"
#   }

#   ingress {
#     from_port = 22
#     to_port = 22
#     cidr_blocks = ["0.0.0.0/0"]
#     protocol = "tcp"
#   }
#     ingress {
#     from_port = 80
#     to_port = 80
#     cidr_blocks = ["0.0.0.0/0"]
#     protocol = "tcp"
#   }

#     egress {
#     from_port = var.egress_from_port
#     to_port = var.egress_to_port
#     cidr_blocks = var.cidr_blocks
#     protocol = "-1"
#   }
# }
