FROM node:4.2.1

COPY . /service

WORKDIR /service
RUN npm install

CMD [ "npm", "start" ]

EXPOSE 3000
