# Etapa 1: Construcción de la aplicación en una imagen de Go
FROM golang:1.23 AS builder

# Configurar el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos del backend
COPY . .

# Descargar dependencias y compilar el binario
RUN go mod tidy && go build -o server

# Etapa 2: Crear una imagen ligera para producción
FROM alpine:latest

# Instalar dependencias necesarias para ejecutar el binario
RUN apk add --no-cache ca-certificates libc6-compat

# Definir el directorio de trabajo
WORKDIR /root/

# Copiar el binario compilado desde la imagen de construcción
COPY --from=builder /app/server .

# Asegurar que el binario tenga permisos de ejecución
RUN chmod +x /root/server

# Exponer el puerto en el que correrá el backend
EXPOSE 8080

# Comando de inicio
CMD ["./server"]
