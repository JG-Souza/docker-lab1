# Etapa 1 - Build
FROM node:22-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

# Copia da pasta onde o Dockerfile está para o diretório dentro do container
COPY . .
RUN npm run build

# Etapa 2 - Produção (mais enxuta)
FROM node:22-alpine AS runner
WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist

# A flag --omit=dev ignora a lista de devDependencies
RUN npm install --omit=dev 

EXPOSE 3000
CMD ["node", "dist/main"]