FROM node:lts-alpine
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --production

# Copia da pasta onde o Dockerfile está para o diretório dentro do container
COPY . .

EXPOSE 3000

CMD ["npm", "start"]