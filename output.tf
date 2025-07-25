# output "default" {
#     value = data.aws_vpc.default.id
# }

# output "subnet_ids_debug" {
#   value = aws_instance.terraform_demo
# }

# output "default_vpc_cidr" {
#   value = data.aws_vpc.custom.cidr_block
# }

# output "instance_id" {
#     value = [for instance in aws_instance.terraform_demo : instance.id]
# }

output "instance_public_ip" {
  value = aws_instance.terraform_demo.public_ip

}