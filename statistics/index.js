const express = require("express");
const app = express();
const port = 3000;

const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

// Connection URL
const url = "mongodb://mongo:27017";

// Database Name
const dbName = "myproject";

// Create a new MongoClient
const client = new MongoClient(url);

// Use connect method to connect to the Server
client.connect(function (err) {
  assert.equal(null, err);
  console.log("Connected successfully to MongoDB");

  const db = client.db(dbName);

  client.close();
});

app.get("/", (req, res) => res.send("Hello World!"));

app.listen(port, () =>
  console.log(`Statistics app listening at http://localhost:${port}`)
);
