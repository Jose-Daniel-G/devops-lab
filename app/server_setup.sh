#!/bin/bash

# ==========================================
# Script de Configuración de Servidor
# ==========================================

# 1. Variables de entorno
APP_ENV="production"
LOG_DIR="/var/log/my_app"
GROUP_NAME="appdeploy"
LOG_FILE="$LOG_DIR/setup.log"

# 2. Validación de permisos (Root / Sudo check)
if [ "$EUID" -ne 0 ]; then
  echo "[ERROR] Este script debe ejecutarse con privilegios de root o sudo." >&2
  exit 1
fi

echo "[INFO] Iniciando despliegue de entorno ($APP_ENV)..."

# 3. Estructura de Directorios y Grupo de Usuarios
if ! getent group "$GROUP_NAME" > /dev/null 2>&1; then
    groupadd "$GROUP_NAME"
    echo "[INFO] Grupo '$GROUP_NAME' creado exitosamente."
else
    echo "[INFO] El grupo '$GROUP_NAME' ya existe."
fi

# Crear directorio de logs si no existe
mkdir -p "$LOG_DIR"

# Asignar propietario (usuario que invoca sudo o root) y grupo
REAL_USER=${SUDO_USER:-$USER}
chown -R "$REAL_USER:$GROUP_NAME" "$LOG_DIR"
chmod -R 775 "$LOG_DIR"

echo "[INFO] Permisos asignados a $LOG_DIR para $REAL_USER:$GROUP_NAME"

# 4. Procesos y Servicios
# Verifica si cron está activo; si falla, intenta iniciarlo
if systemctl is-active --quiet cron status 2>/dev/null || service cron status >/dev/null 2>&1; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [OK] Servicio cron verificado y activo en $APP_ENV" >> "$LOG_FILE"
    echo "[INFO] Log registrado en $LOG_FILE"
else
    echo "[WARN] Servicio cron inactivo. Intentando iniciar..."
    service cron start 2>/dev/null || systemctl start cron 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [OK] Servicio cron iniciado exitosamente" >> "$LOG_FILE"
    else
        echo "[ERROR] No se pudo iniciar el servicio cron" >> "$LOG_FILE"
    fi
fi

echo "[SUCCESS] Configuración del servidor completada."