resource "aws_instance" "devops_sonarqube" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  subnet_id              = data.aws_subnet.selected_subnet.id

  user_data = file("${path.module}/user_data.sh")



  tags = {
    Name = "${var.project_name}-sonarqube"
  }
}
