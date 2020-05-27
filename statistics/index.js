"use strict";

const express = require("express");
const path = require("path");
const dns = require("dns");

const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

const app = express();
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");
app.use("/statistics/assets", express.static(path.join(__dirname, "assets")));

// Config
const expressPort = process.env.PORT || 3000;
const user = encodeURIComponent(`${process.env.MONGO_USERNAME}`);
const password = encodeURIComponent(`${process.env.MONGO_PASSWORD}`);
const authMechanism = "DEFAULT";
const mongoEndpoint = `${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}`;
const url = `mongodb://${user}:${password}@${mongoEndpoint}/?authMechanism=${authMechanism}`;
const dbName = "admin";

// Dynamically get DNS of mongo
async function lookupPromise() {
  return new Promise((resolve, reject) => {
    dns.lookup(`${process.env.MONGO_HOSTNAME}`, (err, address, family) => {
      if (err) reject(err);
      resolve(address);
    });
  });
}

// When a request comes in, connect to MongoDB and respond with statistics
app.get("/statistics", (req, res) => {
  let response = [];
  MongoClient.connect(url, async function (err, client) {
    const mongoInternalIP = await lookupPromise();
    console.log(
      `Connected to MongoDB at ${mongoInternalIP}:${process.env.MONGO_PORT}`
    );
    const adminDb = client.db(dbName).admin();
    const databases = await adminDb.listDatabases();
    const users = await adminDb.command({ usersInfo: { forAllDBs: true } });
    const serverInfo = await adminDb.serverInfo();
    res.render("index", {
      users,
      databases,
      serverInfo,
      mongoInternalIP,
    });
    client.close();
  });
});

// Start Express Server
app.listen(expressPort, () =>
  console.log(
    `MongoDB Statistics App listening at http://localhost:${expressPort}`
  )
);
