
output "vpc_id" {
  value       = data.aws_vpc.selected_vpc.id
  description = "ID de la VPC utilizada para la infraestructura"
}

output "public_subnet_id" {
  value = data.aws_subnet.selected_subnet.id
}

output "sonarqube_ip" {
  value       = aws_instance.devops_sonarqube.public_ip
  description = "IP pública de la instancia EC2 donde está SonarQube"
}
