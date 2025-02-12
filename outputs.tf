output "vpc_id" {
  value       = data.aws_vpc.selected_vpc.id
  description = "ID de la VPC utilizada para la infraestructura"
}

output "public_subnet_id" {
  value = data.aws_subnet.selected_subnet.id
}

output "sonarqube_ip" {
  value = length(aws_instance.devops_sonarqube) > 0 ? aws_instance.devops_sonarqube[0].public_ip : (
    length(data.aws_instances.existing_sonarqube.ids) > 0 ? data.aws_instances.existing_sonarqube.ids[0] : null
  )
}



