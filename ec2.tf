data "aws_instances" "existing_sonarqube" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-sonarqube"]
  }
}

resource "aws_instance" "devops_sonarqube" {
  count                       = length(data.aws_instances.existing_sonarqube.ids) > 0 ? 0 : 1
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.devops_sg.id]
  subnet_id                   = data.aws_subnet.selected_subnet.id
  associate_public_ip_address = true # Asegura que tenga IP pública

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "${var.project_name}-sonarqube"
  }
}
