FROM node:12.16.3-stretch-slim

RUN useradd nodeserver
WORKDIR /opt/app

COPY . .

RUN npm install
EXPOSE 8080

USER nodeserver
ENTRYPOINT ["node"]
CMD ["index.js"]