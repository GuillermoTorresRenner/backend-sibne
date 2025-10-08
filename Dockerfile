# Usar Node.js 18 LTS como imagen base
FROM node:18-alpine AS base

# Instalar dependencias del sistema necesarias para Prisma y bcrypt
RUN apk add --no-cache \
    openssl \
    libc6-compat \
    python3 \
    make \
    g++

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./
COPY prisma ./prisma/

# Etapa de dependencias
FROM base AS dependencies
RUN npm ci --only=production && npm cache clean --force

# Etapa de construcción
FROM base AS build
RUN npm ci
COPY . .

# Generar el cliente de Prisma
RUN npx prisma generate

# Compilar la aplicación
RUN npm run build

# Etapa de producción
FROM node:18-alpine AS production

# Instalar dependencias del sistema para producción
RUN apk add --no-cache openssl libc6-compat

# Crear usuario no-root para seguridad
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nestjs -u 1001

WORKDIR /app

# Copiar dependencias de producción
COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=dependencies /app/package*.json ./

# Copiar archivos compilados
COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma

# Copiar scripts necesarios (para migraciones y otros comandos)
COPY --from=build /app/scripts ./scripts

# Cambiar propiedad de archivos al usuario nestjs
RUN chown -R nestjs:nodejs /app
USER nestjs

# Exponer el puerto
EXPOSE 3000

# Variables de entorno por defecto
ENV NODE_ENV=production
ENV PORT=3000

# Comando por defecto
CMD ["node", "dist/main"]