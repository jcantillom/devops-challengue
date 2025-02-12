#!/bin/bash
set -e
LOGFILE="/var/log/user_data.log"
exec > >(tee -a $LOGFILE) 2>&1

echo "🚀 Iniciando script de User Data..."
echo "🚀 Actualizando paquetes..."
sudo apt update -y
sudo apt upgrade -y

echo "📌 Instalando dependencias..."
sudo apt install -y openjdk-17-jdk postgresql postgresql-contrib unzip wget net-tools

echo "📌 Configurando PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo -u postgres psql -c "CREATE DATABASE sonarqube;"
sudo -u postgres psql -c "CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;"

echo "📌 Descargando SonarQube..."
cd /opt
sudo wget -q https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.8.100196.zip
sudo unzip sonarqube-9.9.8.100196.zip
sudo mv sonarqube-9.9.8.100196 sonarqube
sudo rm sonarqube-9.9.8.100196.zip

echo "📌 Configurando SonarQube..."
sudo sed -i 's/#sonar.jdbc.username=/sonar.jdbc.username=sonar/' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's/#sonar.jdbc.password=/sonar.jdbc.password=sonar/' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's|^#sonar.jdbc.url=.*|sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube?currentSchema=public|' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's/#sonar.web.host=127.0.0.1/sonar.web.host=0.0.0.0/' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's/#sonar.web.port=9000/sonar.web.port=9000/' /opt/sonarqube/conf/sonar.properties

# Agregar configuración de memoria para Elasticsearch si no existe
grep -qxF 'sonar.search.javaOpts=-Xms512m -Xmx512m' /opt/sonarqube/conf/sonar.properties || echo 'sonar.search.javaOpts=-Xms512m -Xmx512m' | sudo tee -a /opt/sonarqube/conf/sonar.properties

echo "📌 Configurando límites de memoria para Elasticsearch..."
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "📌 Creando usuario y permisos para SonarQube..."
sudo adduser --system --no-create-home --group --disabled-login sonarqube || true
sudo chown -R sonarqube:sonarqube /opt/sonarqube
sudo chmod -R 775 /opt/sonarqube

echo "📌 Creando servicio systemd para SonarQube..."
sudo bash -c 'cat > /etc/systemd/system/sonarqube.service <<EOF
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOF'

echo "📌 Reiniciando servicios..."
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl restart postgresql
sudo systemctl restart sonarqube

echo "✅ Instalación y configuración completada."
echo "🔗 Accede a SonarQube en http://$(curl -s ifconfig.me):9000"