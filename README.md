# Desarrollo del Reto Técnico de DevOps - Skill Hacking Banistmo

## 1. Introducción

- Automatizar la instalación y configuración de SonarQube en AWS.
- Implementar una estrategia DevOps para mejorar los tiempos de entrega.
- Configurar un pipeline en Azure DevOps para la orquestación de despliegues.
- Demostrar la estrategia al CTO y la gerencia de tecnología con un prototipo funcional.

## 2. Selección del Workflow de Git

Para este proyecto se eligió el enfoque **Trunk-Based Development**, en el cual:

- Se crean ramas **cortas y efímeras** (`feature/*`) para modificaciones específicas.
- Menos ramas = Menos conflictos.
- La infraestructura cambia con menor frecuencia, por lo que no se justifica la sobrecarga de ramas (Overhead).
- Infraestructura más estable.

### **Justificación:**
✅ Menos ramas = Menos conflictos.  
✅ Trunk-Based simplifica el flujo de trabajo y asegura que la infraestructura esté siempre alineada y validada antes de aplicarse.  
✅ Infraestructura cambia más lentamente que el código de una aplicación.  
✅ Múltiples ramas pueden causar configuraciones inconsistentes.  
✅ Más estabilidad en la infraestructura.

## 3. Automatización de SonarQube con Terraform

Se utilizó **Terraform** para la creación y configuración de la infraestructura en AWS.

### **Infraestructura Provisionada:**

✅ **Instancia EC2 (Ubuntu) con SonarQube**  
✅ **Grupo de Seguridad (Security Group) con reglas para SSH y puerto 9000**  
✅ **Configuración de PostgreSQL como base de datos**  
✅ **Estrategia de "Infrastructure as Code" con Terraform**  
