# Imagen base pequeña y eficiente
FROM node:18-alpine

# Crear directorio de trabajo
WORKDIR /reditos-app

# Copiar dependencias
COPY package*.json ./
RUN npm install

# Copiar el resto del código
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando para iniciar la app
CMD ["npm", "start"]
