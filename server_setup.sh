#!/bin/bash

# 1. Variables de entorno
APP_ENV="production"
LOG_DIR="/var/log/my_app"

# 2. Validación de permisos (Root / Sudo check)
if [ "$EUID" -ne 0 ]; then
  echo "Error: Este script debe ejecutarse con privilegios de root o sudo."
  exit 1
fi

# 3. Estructura y Permisos
# TODO: Crear directorio, crear grupo 'appdeploy', cambiar propietario y permisos (775)

# 4. Procesos y Servicios
# TODO: Verificar si el servicio está activo y escribir en $LOG_DIR/setup.log

echo "Configuración completada exitosamente."
