FROM node:12.16.3-stretch-slim

RUN useradd nodeserver
WORKDIR /usr/src/app

COPY . .

RUN npm install
EXPOSE 8080

USER nodeserver
ENTRYPOINT ["node"]
CMD ["index.js"]