const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

const user = encodeURIComponent(`${process.env.MONGO_USERNAME}`);
const password = encodeURIComponent(`${process.env.MONGO_PASSWORD}`);
const authMechanism = "DEFAULT";

// Connection URL
const mongoHost = `${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}`;
const url = `mongodb://${user}:${password}@${mongoHost}/?authMechanism=${authMechanism}`;

// Create a new MongoClient
const client = new MongoClient(url, err);

// Use connect method to connect to the Server
client.connect(function (err) {
  assert.equal(null, err);
  console.log(`Connected correctly to MongoDB at mongodb://${mongoHost}`);

  // client.close();
});

client.connect(function (err) {
  assert.equal(null, err);
  console.log(`Connected correctly to MongoDB at mongodb://${mongoHost}`);

  // client.close();
});

client.connect(function (err) {
  assert.equal(null, err);
  console.log(`Connected correctly to MongoDB at mongodb://${mongoHost}`);

  // client.close();
});

client.connect(function (err) {
  assert.equal(null, err);
  console.log(`Connected correctly to MongoDB at mongodb://${mongoHost}`);

  // client.close();
});

const MongoClient = require("mongodb").MongoClient;

const test = require("assert");

const user = encodeURIComponent(`${process.env.MONGO_USERNAME}`);
const password = encodeURIComponent(`${process.env.MONGO_PASSWORD}`);
const authMechanism = "DEFAULT";

// Connection url
const mongoHost = `${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}`;
const url = `mongodb://${user}:${password}@${mongoHost}/?authMechanism=${authMechanism}`;

const dbName = "test";

MongoClient.connect(url, function (err, client) {
  // Use the admin database for the operation

  const adminDb = client.db(dbName).admin();

  // adminDb.buildInfo(function (err, dbs) {
  //   test.equal(null, err);
  //   // test.ok(dbs.databases.length > 0);
  //   console.log(dbs);
  // });

  adminDb.serverInfo(function (err, dbs) {
    test.equal(null, err);
    // test.ok(dbs.databases.length > 0);
    console.log(dbs);
  });

  adminDb.serverStatus(function (err, dbs) {
    test.equal(null, err);
    // test.ok(dbs.databases.length > 0);
    console.log(dbs);
  });

  // List all the available databases
  adminDb.listDatabases(function (err, dbs) {
    test.equal(null, err);
    test.ok(dbs.databases.length > 0);
    console.log("listDatabases:");
    console.log(dbs);
  });
});
