FROM node:25-alpine

WORKDIR /myapp

 COPY . .

RUN npm install

CMD [ "npm", "start"]