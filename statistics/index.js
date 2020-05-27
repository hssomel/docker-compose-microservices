const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

const user = encodeURIComponent(`${process.env.MONGO_USERNAME}`);
const password = encodeURIComponent(`${process.env.MONGO_PASSWORD}`);
const authMechanism = "DEFAULT";

// Connection URL
const mongoHost = `${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}`;
const url = `mongodb://${user}:${password}@${mongoHost}/?authMechanism=${authMechanism}`;

// Create a new MongoClient
const client = new MongoClient(url);

// Use connect method to connect to the Server
client.connect(function (err) {
  assert.equal(null, err);
  console.log(`Connected to MongoDB at ${mongoHost}`);

  // client.close();
});
