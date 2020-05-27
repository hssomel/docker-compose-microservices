const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

// MongoDB Connection Config
const user = encodeURIComponent(`${process.env.MONGO_USERNAME}`);
const password = encodeURIComponent(`${process.env.MONGO_PASSWORD}`);
const authMechanism = "DEFAULT";
const mongoHost = `${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}`;
const url = `mongodb://${user}:${password}@${mongoHost}/?authMechanism=${authMechanism}`;
const dbName = "admin";

// When a request comes in, connect to MongoDB and respond with statistics
app.get("/", (req, res) => {
  let response = [];
  MongoClient.connect(url, async function (err, client) {
    const adminDb = client.db(dbName).admin();
    response.push(await adminDb.listDatabases());
    response.push(await adminDb.command({ usersInfo: { forAllDBs: true } }));
    response.push(await adminDb.serverInfo());
    res.send(response);
    client.close();
  });
});

app.listen(port, () =>
  console.log(`MongoDB Statistics App listening at http://localhost:${port}`)
);
