# 1. Imagen base oficial ligera de Node.js
FROM node:18-alpine

# 2. Directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiar el archivo de la aplicación al contenedor
COPY app.js .

# 4. Exponer el puerto en el que escucha el servidor HTTP
EXPOSE 3000

# 5. Comando de arranque al iniciar el contenedor
CMD ["node", "app.js"]