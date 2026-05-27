# Etapa 1: Construcción
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor Web (Nginx)
FROM nginx:alpine
# Copiamos los archivos estáticos generados por React a Nginx
COPY --from=builder /app/dist /usr/share/nginx/html
# Exponemos el puerto del servidor web
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]