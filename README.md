
wsl -u root
docker build -t mi-app:1.0 .
docker run -d -p 3000:3000 --name devops-app mi-app:1.0
docker stop devops-app
docker rm devops-app


docker compose up -d --build
docker compose ps
docker compose logs -f

mkdir -p .github/workflows



# 1. Dar permisos de ejecución
chmod +x server_setup.sh

# 2. Mover al PATH del sistema para invocarlo desde cualquier directorio
sudo mv server_setup.sh /usr/local/bin/server_setup

# 3. Ejecutarlo desde cualquier ruta
sudo server_setup

# 4. Verificar el archivo de log creado
cat /var/log/my_app/setup.log