variable "project_name" {
  description = "Nombre único para identificar los recursos del reto"
  default     = "devops-challenge-cantillojc"
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t3.medium"
}

variable "key_name" {
  description = "Par de claves SSH para la instancia EC2"
  default     = "banitsmo-challenge"
}

variable "existing_vpc_id" {
  description = "ID de una VPC existente en AWS"
  default     = "vpc-04fbcfbc4c486d8ac"
}

variable "existing_subnet_id" {
  description = "ID de una Subnet existente en la VPC"
  default     = "subnet-0dcda78039bcf3ce2"
}

variable "ami_id" {
  description = "ID de la imagen AMI para la instancia EC2"
  default     = "ami-0e1bed4f06a3b463d"
}


