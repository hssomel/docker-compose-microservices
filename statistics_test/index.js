const express = require("express");
const path = require("path");
const app = express();

const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

// Config
const expressPort = process.env.PORT || 3000;
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
    console.log(`Connected to MongoDB at ${mongoHost}`);
    const adminDb = client.db(dbName).admin();
    const databases = await adminDb.listDatabases();
    const users = await adminDb.command({ usersInfo: { forAllDBs: true } });
    const serverInfo = await adminDb.serverInfo();
    console.log(serverInfo);
    res.send(serverInfo);
    // res.render("index");
    client.close();
  });
});

// Start Express Server
app.listen(expressPort, () =>
  console.log(
    `MongoDB Statistics App listening at http://localhost:${expressPort}`
  )
);
