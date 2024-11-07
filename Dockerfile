# Establecer la imagen base
FROM node:18

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar dependencias globales
RUN npm install -g concurrently @angular/cli

# Copiar el frontend y el backend al contenedor
COPY Chat_front/ ./frontend/
COPY Chat_Backend/ ./Chat_Backend/

# Instalar dependencias del frontend
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Instalar dependencias del backend
WORKDIR /app/Chat_Backend
RUN npm install

# Crear un directorio público para servir archivos estáticos
WORKDIR /app
RUN mkdir -p public
RUN cp -r ./frontend/dist/chat-front/* ./public/

# Exponer puertos
EXPOSE 3303 4205

# Comando para iniciar la aplicación
CMD ["concurrently", "cd /app/frontend && ng serve --host 0.0.0.0 --port 4205", "cd /app/Chat_Backend && node server.js"]
